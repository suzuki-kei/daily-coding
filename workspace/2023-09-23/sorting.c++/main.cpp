#include "sorting.hpp"
#include <iostream>

static const int SIZE = 20;

#define DEMONSTRATION(name) \
    demonstration(#name, name)

void demonstration(const char *description, void (*sort)(int *values, int size));
void initialize();
void set_random_values(int *values, int size);
void print_array(const int *values, int size);
bool is_sorted(const int *values, int size);

int main()
{
    DEMONSTRATION(bubble_sort);
    DEMONSTRATION(selection_sort);
    DEMONSTRATION(insertion_sort);
    DEMONSTRATION(merge_sort);
    DEMONSTRATION(quick_sort);

    return 0;
}

void demonstration(const char *description, void (*sort)(int *values, int size))
{
    std::cout << "==== " << description << std::endl;

    int values[SIZE];

    initialize();
    set_random_values(values, SIZE);
    print_array(values, SIZE);
    sort(values, SIZE);
    print_array(values, SIZE);
}

void initialize()
{
    std::srand(std::time(NULL));
}

void set_random_values(int *values, int size)
{
    for (int i = 0; i < size; i++)
        values[i] = std::rand() % 90 + 10;
}

void print_array(const int *values, int size)
{
    const char *delimiter = "";

    for (int i = 0; i < size; i++)
    {
        std::cout << delimiter << values[i];
        delimiter = " ";
    }

    if (is_sorted(values, size))
        std::cout << " (sorted)" << std::endl;
    else
        std::cout << " (not sorted)" << std::endl;
}

bool is_sorted(const int *values, int size)
{
    for (int i = 0; i < size - 1; i++)
        if (values[i] > values[i + 1])
            return false;
    return true;
}

