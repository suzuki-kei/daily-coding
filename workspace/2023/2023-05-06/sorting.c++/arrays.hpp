#include <iostream>

namespace arrays
{

    template
    <
        typename T,
        std::size_t SIZE
    >
    std::size_t size(const T (&)[SIZE])
    {
        return SIZE;
    }

    template
    <
        typename T,
        std::size_t SIZE
    >
    bool is_sorted(const T (&values)[SIZE])
    {
        for (int i = 0; i < SIZE - 1; i++)
            if (values[i] > values[i + 1])
                return false;
        return true;
    }

    template
    <
        typename T,
        std::size_t SIZE
    >
    void print_array(const T (&values)[SIZE])
    {
        for (std::size_t i = 0; i < SIZE; i++)
            std::cout << values[i] << " ";

        if (is_sorted(values))
            std::cout << "(sorted)" << std::endl;
        else
            std::cout << "(not sorted)" << std::endl;
    }

    template
    <
        typename T,
        std::size_t SIZE
    >
    void set_random_values(T (&values)[SIZE])
    {
        for (int i = 0; i < SIZE; i++)
            values[i] = std::rand() % 90 + 10;
    }

}

