#include <cstddef>
#include <algorithm>

namespace sorting
{

    template
    <
        typename T
    >
    void bubble_sort(T *values, int size)
    {
        for (int unsorted_size = size; unsorted_size > 0; unsorted_size--)
            for (int i = 0; i < unsorted_size - 1; i++)
                if (values[i] > values[i + 1])
                    std::swap(values[i], values[i + 1]);
    }

    template
    <
        typename T
    >
    void selection_sort(T *values, int size)
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

    template
    <
        typename T
    >
    void insertion_sort(T *values, int size)
    {
        for (int sorted_size = 1; sorted_size <= size; sorted_size++)
            for (int i = sorted_size - 1; i > 0; i--)
                if (values[i] < values[i - 1])
                    std::swap(values[i], values[i - 1]);
    }

    template
    <
        typename T
    >
    void shaker_sort(T *values, int size)
    {
        int lower = 0;
        int upper = size - 1;

        while (lower <= upper)
        {
            for (int i = lower; i < upper; i++)
                if (values[i] > values[i + 1])
                    std::swap(values[i], values[i + 1]);
            upper--;

            for (int i = upper; i > lower; i--)
                if (values[i] < values[i - 1])
                    std::swap(values[i], values[i - 1]);
            lower++;
        }
    }

    template
    <
        typename T
    >
    void shell_sort(T *values, int size, int hop, int offset)
    {
        for (int sorted_size = 1; sorted_size * hop + offset <= size; sorted_size++)
            for (int i = sorted_size - 1; i >= hop; i -= hop)
                if (values[i] < values[i - hop])
                    std::swap(values[i], values[i - hop]);
    }

    template
    <
        typename T
    >
    void shell_sort(T *values, int size)
    {
        int initial_hop = 1;

        while (initial_hop * 3 + 1 < size / 2)
            initial_hop = initial_hop * 3 + 1;

        for (int hop = initial_hop; hop > 0; hop /= 3)
            for (int offset = 0; offset < hop; offset++)
                shell_sort(values, size, hop, offset);
    }

    template
    <
        typename T
    >
    void merge(T *target, const T *begin1, const T *end1, const T *begin2, const T *end2)
    {
        while (begin1 != end1 && begin2 != end2)
            *target++ = *begin1 < *begin2 ? *begin1++ : *begin2++;
        while (begin1 != end1)
            *target++ = *begin1++;
        while (begin2 != end2)
            *target++ = *begin2++;
    }

    template
    <
        typename T
    >
    void merge_sort(T *values, int size)
    {
        T *buffer = new T[size];
        T *source = values;
        T *target = buffer;

        for (int block_size = 1; block_size < size; block_size *= 2)
        {
            for (int offset = 0; offset < size; offset += block_size * 2)
                merge(
                    &target[offset],
                    &source[std::min(offset + block_size * 0, size)],
                    &source[std::min(offset + block_size * 1, size)],
                    &source[std::min(offset + block_size * 1, size)],
                    &source[std::min(offset + block_size * 2, size)]);
            std::swap(source, target);
        }

        if (values == target)
            std::copy(source, source + size, values);

        delete[] buffer;
    }

    template
    <
        typename T
    >
    void quick_sort(T *values, int lower, int upper)
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
            quick_sort(values, lower, upper_index);
        if (lower_index < upper)
            quick_sort(values, lower_index, upper);
    }

    template
    <
        typename T
    >
    void quick_sort(T *values, int size)
    {
        quick_sort(values, 0, size - 1);
    }

}

