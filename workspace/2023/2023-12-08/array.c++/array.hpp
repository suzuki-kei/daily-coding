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
        using allocator = Allocator;
        using allocator_traits = std::allocator_traits<allocator>;

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

        static std::size_t compute_initial_capacity(const Array *source, std::size_t minimum_capacity)
        {
            if (source != NULL)
                minimum_capacity = std::max(source->m_size, minimum_capacity);

            return compute_initial_capacity(minimum_capacity);
        }

    private:
        std::size_t m_size;
        std::size_t m_capacity;
        allocator m_allocator;
        T *m_memory;

    private:
        Array(const Array *source, std::size_t minimum_capacity)
            : m_size(source == NULL ? 0 : source->m_size),
              m_capacity(compute_initial_capacity(source, minimum_capacity)),
              m_allocator(source == NULL ? allocator() : source->m_allocator),
              m_memory(allocator_traits::allocate(m_allocator, m_capacity))
        {
            if (source != NULL)
                for (std::size_t i = 0; i < source->m_size; i++)
                    allocator_traits::construct(m_allocator, &m_memory[i], source->m_memory[i]);
        }

    public:
        Array(std::size_t minimum_capacity=DEFAULT_MINIMUM_CAPACITY)
            : Array(NULL, minimum_capacity)
        {
        }

        Array(const Array &array, std::size_t minimum_capacity=DEFAULT_MINIMUM_CAPACITY)
            : Array(&array, minimum_capacity)
        {
        }

        ~Array()
        {
            for (std::size_t i = 0; i < m_size; i++)
                allocator_traits::destroy(m_allocator, &m_memory[i]);

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

        std::size_t size() const
        {
            return m_size;
        }

        std::size_t capacity() const
        {
            return m_capacity;
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

        T &operator[](std::size_t i)
        {
            return m_memory[i];
        }

        const T &operator[](std::size_t i) const
        {
            return m_memory[i];
        }

        void push_back(const T &value)
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
    typename T
>
std::ostream &operator<<(std::ostream &ostream, const Array<T> &array)
{
    ostream << "Array(size=" << array.size() << ", capacity=" << array.capacity() << ", values=[";

    const char *delimiter = "";

    for (const T &value : array)
    {
        ostream << delimiter << value;
        delimiter = ", ";
    }

    ostream << "])";

    return ostream;
}

#endif

