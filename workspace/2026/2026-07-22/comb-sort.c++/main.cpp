#include "random.hpp"
#include <cstddef>
#include <cstdio>
#include <iostream>
#include <utility>

void demonstration(Random &random);
void set_random_values(int *array, int n, Random &random);
void print_array(const int *array, int n);
bool is_sorted(const int *array, int n);
void comb_sort(int *array, int n);
int compute_next_gap(int gap);

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
    comb_sort(array, ArrayLength(array));
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

void comb_sort(int *array, int n)
{
    int gap = n;
    bool swapped = false;

    do
    {
        gap = compute_next_gap(gap);
        swapped = false;

        for (int i = 0; i + gap < n; i++)
        {
            if (array[i] > array[i + gap])
            {
                std::swap(array[i], array[i + gap]);
                swapped = true;
            }
        }
    }
    while (gap > 1 || swapped);
}

int compute_next_gap(int gap)
{
    if (gap <= 2)
        return 1;

    if (13 <= gap && gap <= 15)
        return 11;

    return gap * 10 / 13;
}

