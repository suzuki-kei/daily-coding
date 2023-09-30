#ifndef ARRAY_HPP_INCLUDED
#define ARRAY_HPP_INCLUDED

#include <algorithm>
#include <iostream>
#include <memory>

template
<
    typename T,
    typename Allocator = std::allocator<T>
>
class Array
{
private:
    using AllocatorTraits = std::allocator_traits<Allocator>;

private:
    static const std::size_t DEFAULT_MINIMUM_CAPACITY = 16;

private:
    static std::size_t compute_initial_capacity(std::size_t minimum_capacity)
    {
        std::size_t capacity = 1;

        while (capacity < minimum_capacity)
            capacity *= 2;

        return capacity;
    }

private:
    std::size_t m_size;
    std::size_t m_capacity;
    Allocator m_allocator;
    T *m_memory;

public:
    Array(std::size_t minimum_capacity=DEFAULT_MINIMUM_CAPACITY)
        : m_size(0),
          m_capacity(compute_initial_capacity(minimum_capacity)),
          m_allocator(Allocator()),
          m_memory(AllocatorTraits::allocate(m_allocator, m_capacity))
    {
    }

    Array(const Array &array, std::size_t minimum_capacity=DEFAULT_MINIMUM_CAPACITY)
        : m_size(array.m_size),
          m_capacity(compute_initial_capacity(std::max(minimum_capacity, array.m_size))),
          m_allocator(array.m_allocator),
          m_memory(AllocatorTraits::allocate(m_allocator, m_capacity))
    {
        for (std::size_t i = 0; i < array.m_size; i++)
            AllocatorTraits::construct(m_allocator, &m_memory[i], array.m_memory[i]);
    }

    virtual ~Array()
    {
        for (std::size_t i = 0; i < m_size; i++)
            AllocatorTraits::destroy(m_allocator, &m_memory[i]);
        AllocatorTraits::deallocate(m_allocator, m_memory, m_capacity);
    }

    virtual T &operator[](std::size_t i)
    {
        return m_memory[i];
    }

    virtual const T &operator[](std::size_t i) const
    {
        return m_memory[i];
    }

    virtual void swap(Array &array)
    {
        std::swap(m_size, array.m_size);
        std::swap(m_capacity, array.m_capacity);
        std::swap(m_allocator, array.m_allocator);
        std::swap(m_memory, array.m_memory);
    }

    virtual bool empty() const
    {
        return m_size == 0;
    }

    virtual std::size_t size() const
    {
        return m_size;
    }

    virtual std::size_t capacity() const
    {
        return m_capacity;
    }

    virtual void push(const T &value)
    {
        if (m_size == m_capacity)
            Array(*this, m_size + 1).swap(*this);

        AllocatorTraits::construct(m_allocator, &m_memory[m_size], value);
        m_size++;
    }

    virtual void pop()
    {
        AllocatorTraits::destroy(m_allocator, &m_memory[m_size - 1]);
        m_size--;
    }
};

template
<
    typename T,
    typename Allocator
>
std::ostream &operator<<(std::ostream &stream, const Array<T, Allocator> &array)
{
    stream << "Array(size=" << array.size() << ", capacity=" << array.capacity() << ", values=[";

    const char *delimiter = "";

    for (std::size_t i = 0; i < array.size(); i++)
    {
        stream << delimiter << array[i];
        delimiter = ", ";
    }

    stream << "])";

    return stream;
}

#endif

