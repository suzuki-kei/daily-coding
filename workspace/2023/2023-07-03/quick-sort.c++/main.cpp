#include "sorting.hpp"
#include <cstdlib>
#include <ctime>
#include <iostream>

#define SIZE 20

void initialize();
void set_random_values(int *values, int size);
void print_values(const int *values, int size);
bool is_sorted(const int *values, int size);

int main()
{
    initialize();

    int values[SIZE];
    set_random_values(values, SIZE);
    print_values(values, SIZE);
    quick_sort(values, SIZE);
    print_values(values, SIZE);

    return 0;
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

void print_values(const int *values, int size)
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

