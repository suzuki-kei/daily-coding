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
        : m_size(0),
          m_capacity(compute_initial_capacity(minimum_capacity)),
          m_allocator(array.m_allocator),
          m_memory(AllocatorTraits::allocate(m_allocator, m_capacity))
    {
        for (auto it = array.cbegin(); it != array.cend(); it++)
            push_back(*it);
    }

    ~Array()
    {
        for (auto it = begin(); it != end(); it++)
            AllocatorTraits::destroy(m_allocator, it);
        AllocatorTraits::deallocate(m_allocator, m_memory, m_capacity);
    }

    T &operator[](std::size_t i)
    {
        return m_memory[i];
    }

    const T &operator[](std::size_t i) const
    {
        return m_memory[i];
    }

    T *begin()
    {
        return &m_memory[0];
    }

    T *end()
    {
        return &m_memory[m_size];
    }

    const T *cbegin() const
    {
        return &m_memory[0];
    }

    const T *cend() const
    {
        return &m_memory[m_size];
    }

    bool empty() const
    {
        return m_size == 0;
    }

    std::size_t size() const
    {
        return m_size;
    }

    std::size_t capacity() const
    {
        return m_capacity;
    }

    void swap(Array &array)
    {
        std::swap(m_size, array.m_size);
        std::swap(m_capacity, array.m_capacity);
        std::swap(m_allocator, array.m_allocator);
        std::swap(m_memory, array.m_memory);
    }

    void push_back(const T &value)
    {
        if (m_size == m_capacity)
            Array(*this, m_size + 1).swap(*this);

        AllocatorTraits::construct(m_allocator, &m_memory[m_size], value);
        m_size++;
    }

    void pop_back()
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

