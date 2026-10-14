#ifndef ARRAY_INCLUDED
#define ARRAY_INCLUDED

#include <algorithm>
#include <cstddef>
#include <memory>
#include <ostream>
#include <stdexcept>
#include <type_traits>
#include <utility>

template
<
    typename T,
    typename Allocator = std::allocator<T>
>
class Array
{
    private:
        using value_type = T;
        using size_type = std::size_t;
        using allocator_type = Allocator;
        using allocator_traits = std::allocator_traits<allocator_type>;

    private:
        allocator_type m_allocator;
        size_type m_size;
        size_type m_capacity;
        value_type *m_memory;

    private:
        static const size_type DEFAULT_MINIMUM_CAPACITY = 16;

    private:
        static allocator_type copy_allocator(const allocator_type &allocator)
        {
            return allocator_traits::select_on_container_copy_construction(allocator);
        }

        static size_type to_initial_capacity(size_type minimum_capacity, const Array *source)
        {
            if (source != nullptr)
                minimum_capacity = std::max(source->m_size, minimum_capacity);

            size_type capacity = 1;

            while (capacity < minimum_capacity && capacity * 2 > capacity)
                capacity *= 2;

            if (capacity < minimum_capacity)
                capacity = minimum_capacity;

            return capacity;
        }

    private:
        // copy constructor
        Array(const allocator_type &allocator, size_type minimum_capacity, const Array *source)
            : m_allocator(allocator)
            , m_size(0)
            , m_capacity(to_initial_capacity(minimum_capacity, source))
            , m_memory(allocator_traits::allocate(m_allocator, m_capacity))
        {
            try
            {
                if (source == nullptr)
                    return;

                while (m_size != source->m_size)
                {
                    allocator_traits::construct(
                        m_allocator,
                        &m_memory[m_size],
                        source->m_memory[m_size]);
                    m_size++;
                }
            }
            catch (...)
            {
                release();
                throw;
            }
        }

        // move constructor
        Array(const allocator_type &allocator, Array &&source)
            : m_allocator(allocator)
            , m_size(0)
            , m_capacity(to_initial_capacity(source.m_size, &source))
            , m_memory(allocator_traits::allocate(m_allocator, m_capacity))
        {
            try
            {
                while (m_size != source.m_size)
                {
                    allocator_traits::construct(
                        m_allocator,
                        &m_memory[m_size],
                        std::move(source.m_memory[m_size]));
                    m_size++;
                }

                source.release();
            }
            catch (...)
            {
                release();
                throw;
            }
        }

        void take_ownership(Array &source) noexcept
        {
            release();

            m_size = source.m_size;
            m_capacity = source.m_capacity;
            m_memory = source.m_memory;

            source.m_size = 0;
            source.m_capacity = 0;
            source.m_memory = nullptr;
        }

        void release() noexcept
        {
            if (m_memory == nullptr)
                return;

            clear();
            allocator_traits::deallocate(m_allocator, m_memory, m_capacity);
            m_memory = nullptr;
            m_capacity = 0;
        }

    public:
        // constructor
        Array(size_type minimum_capacity = DEFAULT_MINIMUM_CAPACITY)
            : Array(allocator_type(), minimum_capacity, nullptr)
        {
        }

        // copy constructor
        Array(const Array &source, size_type minimum_capacity = DEFAULT_MINIMUM_CAPACITY)
            : Array(copy_allocator(source.m_allocator), minimum_capacity, &source)
        {
        }

        // move constructor
        Array(Array &&source)
            noexcept (
                std::is_nothrow_move_constructible_v<allocator_type>)
            : m_allocator(std::move(source.m_allocator))
            , m_size(source.m_size)
            , m_capacity(source.m_capacity)
            , m_memory(source.m_memory)
        {
            source.m_size = 0;
            source.m_capacity = 0;
            source.m_memory = nullptr;
        }

        // destructor
        ~Array() noexcept
        {
            release();
        }

        // copy assignment
        Array &operator=(const Array &source)
        {
            if constexpr (allocator_traits::propagate_on_container_copy_assignment::value)
                Array(source.m_allocator, source.m_size, &source).swap(*this);
            else
                Array(m_allocator, source.m_size, &source).swap(*this);

            return *this;
        }

        // move assignment
        Array &operator=(Array &&source)
        {
            if (this == &source)
                return *this;

            if constexpr (allocator_traits::propagate_on_container_move_assignment::value)
            {
                m_allocator = std::move(source.m_allocator);
                take_ownership(source);
            }
            else if constexpr (allocator_traits::is_always_equal::value)
            {
                take_ownership(source);
            }
            else if (m_allocator == source.m_allocator)
            {
                take_ownership(source);
            }
            else
            {
                Array(m_allocator, std::move(source)).swap(*this);
            }

            return *this;
        }

        bool empty() const
        {
            return m_size == 0;
        }

        size_type size() const noexcept
        {
            return m_size;
        }

        size_type capacity() const noexcept
        {
            return m_capacity;
        }

        void swap(Array &array)
            noexcept (
                allocator_traits::propagate_on_container_swap::value
                ? std::is_nothrow_swappable_v<allocator_type>
                : allocator_traits::is_always_equal::value)
        {
            if constexpr (allocator_traits::propagate_on_container_swap::value)
                std::swap(m_allocator, array.m_allocator);
            else if constexpr (!allocator_traits::is_always_equal::value)
                if (m_allocator != array.m_allocator)
                    throw std::logic_error("allocators are not equal");

            std::swap(m_size, array.m_size);
            std::swap(m_capacity, array.m_capacity);
            std::swap(m_memory, array.m_memory);
        }

        void clear()
        {
            while (m_size != 0)
            {
                allocator_traits::destroy(m_allocator, &m_memory[m_size - 1]);
                m_size--;
            }
        }

        T *begin()
        {
            return m_memory;
        }

        const T *begin() const
        {
            return m_memory;
        }

        T *end()
        {
            return m_memory + m_size;
        }

        const T *end() const
        {
            return m_memory + m_size;
        }

        void reserve(size_type minimum_capacity)
        {
            if (m_capacity < minimum_capacity)
                Array(m_allocator, minimum_capacity, this).swap(*this);
        }

        void push_back(const value_type &value)
        {
            reserve(m_size + 1);
            allocator_traits::construct(m_allocator, &m_memory[m_size], value);
            m_size++;
        }

        void pop_back()
        {
            allocator_traits::destroy(m_allocator, &m_memory[m_size - 1]);
            m_size--;
        }
};

template
<
    typename T,
    typename Allocator = std::allocator<T>
>
std::ostream &operator<<(std::ostream &ostream, const Array<T, Allocator> &array)
{
    ostream << "Array("
            << "size=" << array.size() << ", "
            << "capacity=" << array.capacity() << ", "
            << "values=[";

    const char *separator = "";

    for (const T &value : array)
    {
        ostream << separator << value;
        separator = ", ";
    }

    ostream << "])";

    return ostream;
}

#endif

