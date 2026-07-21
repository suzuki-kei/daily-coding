#include "random.hpp"
#include <cstddef>
#include <cstdio>
#include <iostream>
#include <utility>

struct PartitionResult
{
    int left_last;
    int right_first;
};

typedef PartitionResult (*FnPartition)(int *array, int first, int last, Random &random);

template
<
    typename T,
    std::size_t N
>
constexpr std::size_t ArrayLength(const T (&array)[N])
{
    return N;
}

void demonstration(const char *label, FnPartition partition, Random &random);
void set_random_values(int *array, int n, Random &random);
void print_array(const int *array, int n);
bool is_sorted(const int *array, int n);
void quick_sort(int *array, int n, FnPartition partition, Random &random);
void quick_sort(int *array, int first, int last, FnPartition partition, Random &random);
PartitionResult partition_2way(int *array, int first, int last, Random &random);
PartitionResult partition_3way(int *array, int first, int last, Random &random);

int main()
{
    Random random;
    demonstration("partition 2-way", partition_2way, random);
    demonstration("partition 3-way", partition_3way, random);
    return 0;
}

void demonstration(const char *label, FnPartition partition, Random &random)
{
    std::printf("==== %s\n", label);
    int array[20];
    set_random_values(array, ArrayLength(array), random);
    print_array(array, ArrayLength(array));
    quick_sort(array, ArrayLength(array), partition, random);
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

void quick_sort(int *array, int n, FnPartition partition, Random &random)
{
    quick_sort(array, 0, n - 1, partition, random);
}

void quick_sort(int *array, int first, int last, FnPartition partition, Random &random)
{
    while (first < last)
    {
        const PartitionResult result = partition(array, first, last, random);
        const int left_size = result.left_last - first + 1;
        const int right_size = last - result.right_first + 1;

        if (left_size <= right_size)
        {
            quick_sort(array, first, result.left_last, partition, random);
            first = result.right_first;
        }
        else
        {
            quick_sort(array, result.right_first, last, partition, random);
            last = result.left_last;
        }
    }
}

PartitionResult partition_2way(int *array, int first, int last, Random &random)
{
    int increment_index = first;
    int decrement_index = last;
    const int pivot = array[random.next(first, last)];

    while (increment_index <= decrement_index)
    {
        while (array[increment_index] < pivot)
            increment_index++;

        while (array[decrement_index] > pivot)
            decrement_index--;

        if (increment_index <= decrement_index)
            std::swap(array[increment_index++], array[decrement_index--]);
    }

    return PartitionResult(decrement_index, increment_index);
}

PartitionResult partition_3way(int *array, int first, int last, Random &random)
{
    int less_end = first;
    int increment_index = first;
    int decrement_index = last;
    const int pivot = array[random.next(first, last)];

    while (increment_index <= decrement_index)
    {
        if (array[increment_index] < pivot)
            std::swap(array[less_end++], array[increment_index++]);
        else if (array[increment_index] > pivot)
            std::swap(array[increment_index], array[decrement_index--]);
        else
            increment_index++;
    }

    return PartitionResult(less_end - 1, increment_index);
}

