#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 20

void initialize(void);
void set_random_values(int *array, int size);
void print_array(const int *array, int size);
int is_sorted(const int *array, int size);
void quick_sort(int *array, int size);
void quick_sort_range(int *array, int lower, int upper);
void swap(int *array, int index1, int index2);

int main(void)
{
    int array[SIZE];

    initialize();
    set_random_values(array, SIZE);
    print_array(array, SIZE);
    quick_sort(array, SIZE);
    print_array(array, SIZE);

    return 0;
}

void initialize(void)
{
    srand(time(NULL));
}

void set_random_values(int *array, int size)
{
    int i;

    for (i = 0; i < size; i++)
        array[i] = rand() % 90 + 10;
}

void print_array(const int *array, int size)
{
    int i;

    for (i = 0; i < size; i++)
        printf("%d ", array[i]);

    if (is_sorted(array, size))
        printf("(sorted)\n");
    else
        printf("(not sorted)\n");
}

int is_sorted(const int *array, int size)
{
    int i;

    for (i = 0; i < size - 1; i++)
        if (array[i] > array[i + 1])
            return 0;
    return 1;
}

void quick_sort(int *array, int size)
{
    quick_sort_range(array, 0, size - 1);
}

void quick_sort_range(int *array, int lower, int upper)
{
    int lower_index = lower;
    int upper_index = upper;
    const int pivot = array[(lower + upper) / 2];

    while (lower_index <= upper_index)
    {
        while (array[lower_index] < pivot)
            lower_index++;
        while (array[upper_index] > pivot)
            upper_index--;
        if (lower_index <= upper_index)
            swap(array, lower_index++, upper_index--);
    }

    if (lower < upper_index)
        quick_sort_range(array, lower, upper_index);
    if (lower_index < upper)
        quick_sort_range(array, lower_index, upper);
}

void swap(int *array, int index1, int index2)
{
    int value1 = array[index1];
    array[index1] = array[index2];
    array[index2] = value1;
}

