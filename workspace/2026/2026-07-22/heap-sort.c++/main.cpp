#include "random.hpp"
#include <cstddef>
#include <cstdio>
#include <iostream>
#include <utility>

void demonstration(Random &random);
void set_random_values(int *array, int n, Random &random);
void print_array(const int *array, int n);
bool is_sorted(const int *array, int n);
void heap_sort(int *array, int n);
void make_heap(int *array, int n);
void pop_all(int *array, int n);
void shift_down(int *array, int n, int i);

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
    heap_sort(array, ArrayLength(array));
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

void heap_sort(int *array, int n)
{
    make_heap(array, n);
    pop_all(array, n);
}

void make_heap(int *array, int n)
{
    for (int i = n / 2 - 1; i >= 0; i--)
        shift_down(array, n, i);
}

void pop_all(int *array, int n)
{
    for (int i = n - 1; i >= 1; i--)
    {
        std::swap(array[0], array[i]);
        shift_down(array, i, 0);
    }
}

void shift_down(int *array, int n, int i)
{
    while (i * 2 + 1 < n)
    {
        int maximum_index = i;
        const int left_index = i * 2 + 1;
        const int right_index = i * 2 + 2;

        if (left_index < n && array[left_index] > array[maximum_index])
            maximum_index = left_index;

        if (right_index < n && array[right_index] > array[maximum_index])
            maximum_index = right_index;

        if (i == maximum_index)
            break;

        std::swap(array[i], array[maximum_index]);
        i = maximum_index;
    }
}

