#ifndef ARRAY_INCLUDED
#define ARRAY_INCLUDED

#include <algorithm>
#include <chrono>
#include <cstddef>
#include <iterator>
#include <memory>
#include <ostream>
#include <stdexcept>
#include <utility>

template
<
    typename T,
    typename Allocator = std::allocator<T>
>
class Array
{
    public:
        using value_type = T;
        using allocator_type = Allocator;
        using size_type = std::size_t;
        using difference_type = std::ptrdiff_t;
        using reference = T &;
        using const_reference = const T &;
        using iterator = T *;
        using const_iterator = const T *;

    private:
        using allocator_traits = std::allocator_traits<allocator_type>;

    private:
        static constexpr size_type DEFAULT_MINIMUM_CAPACITY = 16;

    private:
        static size_type compute_initial_capacity(size_type minimum_capacity)
        {
            if (minimum_capacity > SIZE_MAX / 2)
                return minimum_capacity;

            size_type capacity = 1;

            while (capacity < minimum_capacity)
                capacity *= 2;

            return capacity;
        }

        static size_type compute_initial_capacity(const Array *source, size_type minimum_capacity)
        {
            if (source == nullptr)
                return compute_initial_capacity(minimum_capacity);
            else
                return compute_initial_capacity(std::max(source->m_size, minimum_capacity));
        }

        static allocator_type new_initial_allocator(const Array *source)
        {
            if (source == nullptr)
                return allocator_type();
            else
                return source->m_allocator;
        }

    private:
        size_type m_size;
        size_type m_capacity;
        allocator_type m_allocator;
        T *m_memory;

    private:
        Array(const Array *source, size_type minimum_capacity)
            : m_size(0),
              m_capacity(compute_initial_capacity(source, minimum_capacity)),
              m_allocator(new_initial_allocator(source)),
              m_memory(allocator_traits::allocate(m_allocator, m_capacity))
        {
            if (source != nullptr)
                std::copy(
                    source->begin(),
                    source->end(),
                    std::back_inserter(*this));
        }

    public:
        // default constructor
        Array()
            : Array(nullptr, DEFAULT_MINIMUM_CAPACITY)
        {
        }

        Array(size_type minimum_capacity)
            : Array(nullptr, minimum_capacity)
        {
        }

        Array(const Array &source, size_type minimum_capacity)
            : Array(&source, minimum_capacity)
        {
        }

        // copy constructor
        Array(const Array &source)
            : Array(&source, source.m_size)
        {
        }

        // move constructor
        Array(Array &&source) noexcept
            : m_size(0),
              m_capacity(0),
              m_allocator(allocator_type()),
              m_memory(nullptr)
        {
            swap(source);
        }

        // copy assignment operator
        Array &operator=(const Array &source)
        {
            Array(source).swap(*this);
            return *this;
        }

        // move assignment operator
        Array &operator=(Array &&source) noexcept
        {
            swap(source);
            return *this;
        }

        // destructor
        ~Array() noexcept
        {
            clear();
            allocator_traits::deallocate(m_allocator, m_memory, m_capacity);
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

        void swap(Array &array) noexcept
        {
            std::swap(m_size, array.m_size);
            std::swap(m_capacity, array.m_capacity);
            std::swap(m_allocator, array.m_allocator);
            std::swap(m_memory, array.m_memory);
        }

        void clear() noexcept
        {
            while (!empty())
                pop_back();
        }

        void reserve(size_type minimum_capacity)
        {
            if (m_capacity < minimum_capacity)
                Array(std::move(*this), minimum_capacity).swap(*this);
        }

        void push_back(const T &value)
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

        T &operator[](size_type i)
        {
            return m_memory[i];
        }

        const T &operator[](size_type i) const
        {
            return m_memory[i];
        }

        reference at(size_type i)
        {
            if (i >= m_size)
                throw std::out_of_range(std::format("out of range: i=%d", i));

            return m_memory[i];
        }

        const_reference at(size_type i) const
        {
            if (i >= m_size)
                throw std::out_of_range(std::format("out of range: i=%d", i));

            return m_memory[i];
        }

        iterator begin()
        {
            return &m_memory[0];
        }

        const_iterator begin() const
        {
            return &m_memory[0];
        }

        const_iterator cbegin() const
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

        const_iterator cend() const
        {
            return &m_memory[m_size];
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

