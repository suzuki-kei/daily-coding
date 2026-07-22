#include "random.hpp"
#include <cstddef>
#include <cstdio>
#include <iostream>
#include <utility>

void demonstration(Random &random);
void set_random_values(int *array, int n, Random &random);
void print_array(const int *array, int n);
bool is_sorted(const int *array, int n);
void shell_sort(int *array, int n);
int compute_initial_gap(int n);
void insert(int *array, int i, int gap);

template
<
    typename T,
    std::size_t N
>
constexpr std::size_t ArrayLength(const T (&array)[N])
{
    return N;
}

int main()
{
    Random random;
    demonstration(random);
    return 0;
}

void demonstration(Random &random)
{
    int array[20];
    set_random_values(array, ArrayLength(array), random);
    print_array(array, ArrayLength(array));
    shell_sort(array, ArrayLength(array));
    print_array(array, ArrayLength(array));
}

void set_random_values(int *array, int n, Random &random)
{
    for (int i = 0; i < n; i++)
        array[i] = random.next(10, 99);
}

void print_array(const int *array, int n)
{
    const char *separator = "";

    for (int i = 0; i < n; i++)
    {
        std::printf("%s%d", separator, array[i]);
        separator = " ";
    }

    if (is_sorted(array, n))
        std::printf(" (sorted)\n");
    else
        std::printf(" (not sorted)\n");
}

bool is_sorted(const int *array, int n)
{
    for (int i = 0; i + 1 < n; i++)
        if (array[i] > array[i + 1])
            return false;

    return true;
}

void shell_sort(int *array, int n)
{
    for (int gap = compute_initial_gap(n); gap >= 1; gap /= 3)
        for (int i = gap; i < n; i++)
            insert(array, i, gap);
}

int compute_initial_gap(int n)
{
    int gap = 1;

    while (gap * 3 + 1 < n)
        gap = gap * 3 + 1;

    return gap;
}

void insert(int *array, int i, int gap)
{
    const int value = array[i];

    while (i >= gap && value < array[i - gap])
    {
        array[i] = array[i - gap];
        i -= gap;
    }
    array[i] = value;
}

