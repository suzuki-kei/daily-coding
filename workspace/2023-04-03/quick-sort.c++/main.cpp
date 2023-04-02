#include <iostream>
#include <cstdlib>
#include <ctime>
#include "quick-sort.hpp"

void initialize()
{
    std::srand(std::time(0));
}

template <typename T>
void set_random_values(T *values, int size)
{
    for (int i = 0; i < size; i++)
        values[i] = std::rand() % 90 + 10;
}

template <typename T>
bool is_sorted(const T *values, std::size_t size)
{
    for (std::size_t i = 0; i < size - 1; i++)
        if (values[i] > values[i + 1])
            return false;
    return true;
}

template <typename T>
void print_values(const T *values, std::size_t size)
{
    for (std::size_t i = 0; i < size; i++)
        std::cout << values[i] << " ";

    if (is_sorted(values, size))
        std::cout << "(sorted)" << std::endl;
    else
        std::cout << "(not sorted)" << std::endl;
}

int main(void)
{
    const int size = 20;
    int values[size];

    initialize();
    set_random_values(values, size);
    print_values(values, size);
    quick_sort(values, size);
    print_values(values, size);

    return 0;
}

