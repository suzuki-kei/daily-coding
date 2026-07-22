#include "random.hpp"
#include <algorithm>
#include <cstddef>
#include <cstdio>
#include <iostream>
#include <utility>

void demonstration(Random &random);
void set_random_values(int *array, int n, Random &random);
void print_array(const int *array, int n);
bool is_sorted(const int *array, int n);
void merge_sort(int *array, int n);
void merge(int *output, const int *begin1, const int *end1, const int *begin2, const int *end2);

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
    merge_sort(array, ArrayLength(array));
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

void merge_sort(int *array, int n)
{
    int *buffer = nullptr;
    buffer = new int[n];

    int *input = array;
    int *output = buffer;

    for (int chunk_size = 1; chunk_size < n; chunk_size *= 2)
    {
        for (int i = 0; i + chunk_size < n; i += chunk_size * 2)
        {
            merge(
                &output[i],
                &input[i],
                &input[std::min(n, i + chunk_size)],
                &input[std::min(n, i + chunk_size)],
                &input[std::min(n, i + chunk_size * 2)]);
        }
        std::swap(input, output);
    }

    if (array == output)
        for (int i = 0; i < n; i++)
            array[i] = buffer[i];

    delete[] buffer;
    buffer = nullptr;
}

void merge(int *output, const int *begin1, const int *end1, const int *begin2, const int *end2)
{
    while (begin1 != end1 && begin2 != end2)
    {
        if (*begin1 <= *begin2)
            *output++ = *begin1++;
        else
            *output++ = *begin2++;
    }

    while (begin1 != end1)
        *output++ = *begin1++;

    while (begin2 != end2)
        *output++ = *begin2++;
}

