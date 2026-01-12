#include "sorting.hpp"
#include <cstdlib>
#include <ctime>
#include <iostream>

void initialize();
void demonstration(const char *description, void (*sort)(int *values, int size));
void set_random_values(int *values, int size);
void print_values(const int *values, int size);
bool is_sorted(const int *values, int size);

#define DEMONSTRATION(name) \
    demonstration(#name, name)

int main()
{
    initialize();

    DEMONSTRATION(bubble_sort);
    DEMONSTRATION(selection_sort);
    DEMONSTRATION(insertion_sort);
    DEMONSTRATION(quick_sort);

    return 0;
}

void initialize()
{
    std::srand(std::time(NULL));
}

void demonstration(const char *description, void (*sort)(int *values, int size))
{
    std::cout << "==== " << description << std::endl;

    const int SIZE = 20;
    int values[SIZE];
    set_random_values(values, SIZE);
    print_values(values, SIZE);
    sort(values, SIZE);
    print_values(values, SIZE);
}

void set_random_values(int *values, int size)
{
    for (int i = 0; i < size; i++)
        values[i] = std::rand() % 90 + 10;
}

void print_values(const int *values, int size)
{
    for (int i = 0; i < size; i++)
        std::cout << values[i] << " ";

    if (is_sorted(values, size))
        std::cout << "(sorted)" << std::endl;
    else
        std::cout << "(not sorted)" << std::endl;
}

bool is_sorted(const int *values, int size)
{
    for (int i = 0; i < size - 1; i++)
        if (values[i] > values[i + 1])
            return false;

    return true;
}

