#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "main.h"

#define SIZE 20

int main(void)
{
    int values[SIZE];

    initialize();
    set_random_values(values, SIZE);
    print_values(values, SIZE);
    quick_sort(values, SIZE);
    print_values(values, SIZE);

    return 0;
}

void initialize()
{
    srand(time(NULL));
}

void set_random_values(int *values, int size)
{
    int i;

    for (i = 0; i < size; i++)
        values[i] = rand() % 90 + 10;
}

int is_sorted(const int *values, int size)
{
    int i;

    for (i = 0; i < size - 1; i++)
        if (values[i] > values[i + 1])
            return 0;
    return 1;
}

void print_values(const int *values, int size)
{
    int i;

    for (i = 0; i < size; i++)
        printf("%d ", values[i]);

    if (is_sorted(values, size))
        printf("(sorted)\n");
    else
        printf("(not sorted)\n");
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

    if (lower_index < upper)
        _quick_sort(values, lower_index, upper);
    if (lower < upper_index)
        _quick_sort(values, lower, upper_index);
}

void swap(int *values, int index1, int index2)
{
    int value = values[index1];
    values[index1] = values[index2];
    values[index2] = value;
}

