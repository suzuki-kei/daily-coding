#ifndef SORTING_HPP_INCLUDED
#define SORTING_HPP_INCLUDED

#include <utility>

void bubble_sort(int *values, int size)
{
    for (int unsorted_size = size; unsorted_size > 0; unsorted_size--)
        for (int i = 0; i < unsorted_size - 1; i++)
            if (values[i] > values[i + 1])
                std::swap(values[i], values[i + 1]);
}

void selection_sort(int *values, int size)
{
    for (int sorted_size = 0; sorted_size < size; sorted_size++)
    {
        int minimum_index = sorted_size;

        for (int i = sorted_size + 1; i < size; i++)
            if (values[i] < values[minimum_index])
                minimum_index = i;
        std::swap(values[sorted_size], values[minimum_index]);
    }
}

void insertion_sort(int *values, int size)
{
    for (int sorted_size = 1; sorted_size < size; sorted_size++)
        for (int i = sorted_size; i > 0 && values[i] < values[i - 1]; i--)
            std::swap(values[i], values[i - 1]);
}

void quick_sort(int *values, int lower, int upper)
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
            std::swap(values[lower_index++], values[upper_index--]);
    }

    if (lower < upper_index)
        quick_sort(values, lower, upper_index);
    if (lower_index < upper)
        quick_sort(values, lower_index, upper);
}

void quick_sort(int *values, int size)
{
    quick_sort(values, 0, size - 1);
}

#endif

