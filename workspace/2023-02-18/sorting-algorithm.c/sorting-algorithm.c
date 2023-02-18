#include <stdlib.h>
#include "sorting-algorithm.h"

void swap(int *values, int index1, int index2);
int minimum(int value1, int value2);
void _quick_sort(int *values, int lower, int upper);

void swap(int *values, int index1, int index2)
{
    const int value1 = values[index1];
    values[index1] = values[index2];
    values[index2] = value1;
}

int minimum(int value1, int value2)
{
    return (value1 < value2) ? value1 : value2;
}

void bubble_sort(int *values, int size)
{
    int i;
    int unsorted_size;

    for (unsorted_size = size; unsorted_size > 0; unsorted_size--)
        for (i = 0; i < unsorted_size - 1; i++)
            if (values[i] > values[i + 1])
                swap(values, i, i + 1);
}

void insertion_sort(int *values, int size)
{
    int i;
    int lower;
    int minimum;

    for (lower = 0; lower < size; lower++)
    {
        for (i = minimum = lower; i < size; i++)
            if (values[i] < values[minimum])
                minimum = i;
        swap(values, lower, minimum);
    }
}

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

    if (lower < upper_index)
        _quick_sort(values, lower, upper_index);
    if (lower_index < upper)
        _quick_sort(values, lower_index, upper);
}

