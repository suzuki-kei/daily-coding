#include <iostream>
#include <cstdlib>
#include <ctime>
#include "arrays.hpp"
#include "sorting.hpp"

void initialize();
void demonstration(const char *description, void (*sort)(int *values, int size));

#define DEMONSTRATION(name) \
    demonstration(#name, sorting::name)

int main()
{
    initialize();
    DEMONSTRATION(bubble_sort);
    DEMONSTRATION(selection_sort);
    DEMONSTRATION(insertion_sort);
    DEMONSTRATION(shaker_sort);
    DEMONSTRATION(shell_sort);
    DEMONSTRATION(merge_sort);
    DEMONSTRATION(quick_sort);
    return 0;
}

void initialize()
{
    std::srand(std::time(NULL));
}

void demonstration(const char *description, void (*sort)(int *values, int size))
{
    std::cout << description << ":" << std::endl;

    int values[20];
    arrays::set_random_values(values);
    arrays::print_array(values);
    sort(values, arrays::size(values));
    arrays::print_array(values);
}

