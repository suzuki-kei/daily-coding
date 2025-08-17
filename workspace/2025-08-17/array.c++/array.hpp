#ifndef ARRAY_HPP_INCLUDED
#define ARRAY_HPP_INCLUDED

#include <algorithm>
#include <cstddef>
#include <memory>
#include <new>
#include <ostream>

template
<
    typename T,
    typename Allocator = std::allocator<T>
>
class Array
{
    private:
        using allocator = Allocator;
        using allocator_traits = std::allocator_traits<allocator>;

    private:
        static const std::size_t DEFAULT_MINIMUM_CAPACITY = 16;

    private:
        static std::size_t initial_capacity(std::size_t minimum_capacity)
        {
            std::size_t capacity = 1;

            while (capacity < minimum_capacity)
                if (capacity * 2 < capacity)
                    throw std::bad_alloc();
                else
                    capacity *= 2;

            return capacity;
        }

        static std::size_t initial_capacity(const Array *source, std::size_t minimum_capacity)
        {
            if (source == nullptr)
                return initial_capacity(minimum_capacity);
            else
                return initial_capacity(std::max(minimum_capacity, source->m_size));
        }

        static allocator initial_allocator(const Array *source)
        {
            if (source == nullptr)
                return allocator();
            else
                return source->m_allocator;
        }

    private:
        std::size_t m_size;
        std::size_t m_capacity;
        allocator m_allocator;
        T *m_memory;

    private:
        Array(const Array *source, std::size_t minimum_capacity)
            : m_size(0),
              m_capacity(initial_capacity(source, minimum_capacity)),
              m_allocator(initial_allocator(source)),
              m_memory(allocator_traits::allocate(m_allocator, m_capacity))
        {
            if (source != nullptr)
                for (const T &value : *source)
                    push_back(value);
        }

    public:
        Array(std::size_t minimum_capacity=DEFAULT_MINIMUM_CAPACITY)
            : Array(nullptr, minimum_capacity)
        {
        }

        Array(const Array &source, std::size_t minimum_capacity=DEFAULT_MINIMUM_CAPACITY)
            : Array(&source, minimum_capacity)
        {
        }

        ~Array()
        {
            clear();
            allocator_traits::deallocate(m_allocator, m_memory, m_capacity);
        }

        Array &operator=(const Array &array)
        {
            Array(&array).swap(*this);
        }

        void swap(Array &array)
        {
            std::swap(m_size, array.m_size);
            std::swap(m_capacity, array.m_capacity);
            std::swap(m_allocator, array.m_allocator);
            std::swap(m_memory, array.m_memory);
        }

        T *begin()
        {
            return &m_memory[0];
        }

        const T *begin() const
        {
            return &m_memory[0];
        }

        T *end()
        {
            return &m_memory[m_size];
        }

        const T *end() const
        {
            return &m_memory[m_size];
        }

        void clear()
        {
            while (!empty())
                pop_back();
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

        void reserve(std::size_t minimum_capacity)
        {
            if (m_capacity < minimum_capacity)
                Array(*this, minimum_capacity).swap(*this);
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

