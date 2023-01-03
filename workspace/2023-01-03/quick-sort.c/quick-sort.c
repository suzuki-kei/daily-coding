#include "quick-sort.h"

void quick_sort(int *values, int size)
{
    _quick_sort(values, 0, size - 1);
}

void _quick_sort(int *values, int lower, int upper)
{
    int lower_index = lower;
    int upper_index = upper;
    const int pivot = values[(lower + upper) / 2];

    while (lower_index <= upper_index)
    {
        while (values[lower_index] < pivot)
            lower_index++;
        while (pivot < values[upper_index])
            upper_index--;
        if (lower_index <= upper_index)
            swap(values, lower_index++, upper_index--);
    }

    if (lower_index < upper)
        _quick_sort(values, lower_index, upper);
    if (lower < upper_index)
        _quick_sort(values, lower, upper_index);
}

void swap(int *values, int index1, int index2)
{
    const int value1 = values[index1];
    values[index1] = values[index2];
    values[index2] = value1;
}

