#ifndef SORTING_HPP_INCLUDED
#define SORTING_HPP_INCLUDED

#include <algorithm>

template
<
    typename T
>
void _quick_sort(T *values, int lower, int upper)
{
    int lower_index = lower;
    int upper_index = upper;
    const T pivot = values[(lower + upper) / 2];

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
        _quick_sort(values, lower, upper_index);
    if (lower_index < upper)
        _quick_sort(values, lower_index, upper);
}

template
<
    typename T
>
void quick_sort(T *values, int size)
{
    _quick_sort(values, 0, size - 1);
}

#endif

