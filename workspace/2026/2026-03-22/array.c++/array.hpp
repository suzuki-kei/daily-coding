#ifndef ARRAY_INCLUDED
#define ARRAY_INCLUDED

#include <algorithm>
#include <cstddef>
#include <limits>
#include <memory>
#include <ostream>
#include <utility>

template
<
    typename T,
    typename Allocator = std::allocator<T>
>
class Array
{
    public:
        using allocator_traits = std::allocator_traits<Allocator>;
        using allocator_type = Allocator;
        using const_iterator = const T *;
        using const_reference = const T &;
        using iterator = T *;
        using pointer = T *;
        using reference = T &;
        using size_type = std::size_t;
        using value_type = T;

    public:
        Array()
            : Array(nullptr, DEFAULT_MINIMUM_CAPACITY)
        {
        }

        Array(size_type minimum_capacity)
            : Array(nullptr, minimum_capacity)
        {
        }

        Array(const Array &source)
            : Array(&source, source.m_size)
        {
        }

        Array(const Array &source, size_type minimum_capacity)
            : Array(&source, minimum_capacity)
        {
        }

        ~Array() noexcept
        {
            clear();
            allocator_traits::deallocate(m_allocator, m_memory, m_capacity);
        }

        iterator begin()
        {
            return &m_memory[0];
        }

        const_iterator begin() const
        {
            return &m_memory[0];
        }

        iterator end()
        {
            return &m_memory[m_size];
        }

        const_iterator end() const
        {
            return &m_memory[m_size];
        }

        void clear() noexcept
        {
            while (!empty())
                pop_back();
        }

        bool empty() const noexcept
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

        void reserve(size_type minimum_capacity)
        {
            if (m_capacity < minimum_capacity)
                Array(*this, minimum_capacity).swap(*this);
        }

        void push_back(const value_type &value)
        {
            reserve(m_size + 1);
            allocator_traits::construct(m_allocator, &m_memory[m_size], value);
            m_size++;
        }

        void swap(Array &array) noexcept
        {
            std::swap(m_size, array.m_size);
            std::swap(m_capacity, array.m_capacity);
            std::swap(m_allocator, array.m_allocator);
            std::swap(m_memory, array.m_memory);
        }

        void pop_back()
        {
            allocator_traits::destroy(m_allocator, &m_memory[m_size - 1]);
            m_size--;
        }

        reference operator[](size_type i)
        {
            return m_memory[i];
        }

        const_reference operator[](size_type i) const
        {
            return m_memory[i];
        }

    private:
        static constexpr size_type DEFAULT_MINIMUM_CAPACITY = 16;

    private:
        size_type m_size;
        size_type m_capacity;
        allocator_type m_allocator;
        pointer m_memory;

    private:
        static const size_type compute_initial_capacity(size_type minimum_capacity)
        {
            if (minimum_capacity > std::numeric_limits<size_type>::max() / 2)
                return minimum_capacity;

            size_type capacity = 1;

            while (capacity < minimum_capacity)
                capacity *= 2;

            return capacity;
        }

        static const size_type compute_initial_capacity(const Array *source, size_type minimum_capacity)
        {
            if (source == nullptr)
                return compute_initial_capacity(minimum_capacity);
            else
                return compute_initial_capacity(std::max(source->m_size, minimum_capacity));
        }

    private:
        Array(const Array *source, size_type minimum_capacity)
            : m_size(0),
              m_capacity(compute_initial_capacity(source, minimum_capacity)),
              m_allocator(source == nullptr ? allocator_type() : source->m_allocator),
              m_memory(allocator_traits::allocate(m_allocator, m_capacity))
        {
            if (source != nullptr)
                for (const T &value : *source)
                    push_back(value);
        }
};

template
<
    typename T,
    typename Allocator
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

