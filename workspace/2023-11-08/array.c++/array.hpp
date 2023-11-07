#ifndef ARRAY_HPP_INCLUDED
#define ARRAY_HPP_INCLUDED

#include <algorithm>
#include <memory>
#include <ostream>

template
<
    typename T,
    typename Allocator = std::allocator<T>
>
class Array
{
private:
    using allocator_traits = std::allocator_traits<Allocator>;
    using allocator_type = typename allocator_traits::allocator_type;
    using value_type = typename allocator_traits::value_type;
    using size_type = typename allocator_traits::size_type;
    using pointer = typename allocator_traits::pointer;
    using iterator = typename allocator_traits::pointer;
    using const_iterator = typename allocator_traits::const_pointer;
    using reference = value_type &;
    using const_reference = const value_type &;

private:
    static const size_type DEFAULT_MINIMUM_CAPACITY = 16;

private:
    static size_type compute_initial_capacity(size_type minimum_capacity)
    {
        size_type capacity = 1;

        while (capacity < minimum_capacity)
            capacity *= 2;

        return capacity;
    }

private:
    size_type m_size;
    size_type m_capacity;
    allocator_type m_allocator;
    pointer m_memory;

public:
    Array(size_type minimum_capacity=DEFAULT_MINIMUM_CAPACITY)
        : m_size(0),
          m_capacity(compute_initial_capacity(minimum_capacity)),
          m_allocator(allocator_type()),
          m_memory(allocator_traits::allocate(m_allocator, m_capacity))
    {
    }

    Array(const Array &array, size_type minimum_capacity=DEFAULT_MINIMUM_CAPACITY)
        : m_size(array.m_size),
          m_capacity(compute_initial_capacity(std::max(array.m_size, minimum_capacity))),
          m_allocator(allocator_type()),
          m_memory(allocator_traits::allocate(m_allocator, m_capacity))
    {
        for (size_type i = 0; i < array.m_size; i++)
            allocator_traits::construct(m_allocator, &m_memory[i], array.m_memory[i]);
    }

    ~Array()
    {
        for (auto it = begin(); it != end(); it++)
            allocator_traits::destroy(m_allocator, it);

        allocator_traits::deallocate(m_allocator, m_memory, m_capacity);
    }

    void swap(Array &array)
    {
        std::swap(m_size, array.m_size);
        std::swap(m_capacity, array.m_capacity);
        std::swap(m_allocator, array.m_allocator);
        std::swap(m_memory, array.m_memory);
    }

    bool empty() const
    {
        return m_size == 0;
    }

    size_type size() const
    {
        return m_size;
    }

    size_type capacity() const
    {
        return m_capacity;
    }

    iterator begin()
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

    const_iterator cend() const
    {
        return &m_memory[m_size];
    }

    reference operator[](size_type i)
    {
        return m_memory[i];
    }

    const_reference operator[](size_type i) const
    {
        return m_memory[i];
    }

    void push_back(const_reference value)
    {
        if (m_size == m_capacity)
            Array(*this, m_size + 1).swap(*this);

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
    typename Allocator
>
std::ostream &operator<<(std::ostream &ostream, const Array<T, Allocator> &array)
{
    ostream << "Array(size=" << array.size() << ", capacity=" << array.capacity() << ", values=[";

    const char *delimiter = "";

    for (auto it = array.cbegin(); it != array.cend(); it++)
    {
        ostream << delimiter << *it;
        delimiter = ", ";
    }

    ostream << "])";

    return ostream;
}

#endif

