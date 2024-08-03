#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 20

void initialize(void);
void demonstration(void);
void set_random_values(int *array, int size);
void print_array(const int *array, int size);
int is_sorted(const int *array, int size);
void quick_sort(int *array, int size);
void quick_sort_range(int *array, int lower, int upper);
void swap(int *value1, int *value2);

int main(void)
{
    initialize();
    demonstration();

    return 0;
}

void initialize(void)
{
    srand(time(NULL));
}

void demonstration(void)
{
    int array[SIZE];

    set_random_values(array, SIZE);
    print_array(array, SIZE);
    quick_sort(array, SIZE);
    print_array(array, SIZE);
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
    const char *separator = "";

    for (i = 0; i < size; i++)
    {
        printf("%s%d", separator, array[i]);
        separator = " ";
    }

    if (is_sorted(array, size))
        printf(" (sorted)\n");
    else
        printf(" (not sorted)\n");
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
    int less_index = lower;
    int greater_index = upper;
    const int pivot = array[(lower + upper) / 2];

    while (less_index <= greater_index)
    {
        while (array[less_index] < pivot)
            less_index++;
        while (array[greater_index] > pivot)
            greater_index--;
        if (less_index <= greater_index)
            swap(&array[less_index++], &array[greater_index--]);
    }

    if (lower < greater_index)
        quick_sort_range(array, lower, greater_index);
    if (less_index < upper)
        quick_sort_range(array, less_index, upper);
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

