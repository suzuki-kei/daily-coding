#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 20

void initialize(void);
void demonstration(void);
void set_random_values(int *values, int size);
void print_array(const int *values, int size);
int is_sorted(const int *values, int size);
void quick_sort(int *values, int size);
void quick_sort_range(int *values, int lower, int upper);
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
    int values[SIZE];

    set_random_values(values, SIZE);
    print_array(values, SIZE);
    quick_sort(values, SIZE);
    print_array(values, SIZE);
}

void set_random_values(int *values, int size)
{
    int i;

    for (i = 0; i < size; i++)
        values[i] = rand() % 90 + 10;
}

void print_array(const int *values, int size)
{
    int i;
    const char *separator = "";

    for (i = 0; i < size; i++)
    {
        printf("%s%d", separator, values[i]);
        separator = " ";
    }

    if (is_sorted(values, size))
        printf(" (sorted)\n");
    else
        printf(" (not sorted)\n");
}

int is_sorted(const int *values, int size)
{
    int i;

    for (i = 0; i < size - 1; i++)
        if (values[i] > values[i + 1])
            return 0;
    return 1;
}

void quick_sort(int *values, int size)
{
    quick_sort_range(values, 0, size - 1);
}

void quick_sort_range(int *values, int lower, int upper)
{
    int lower_index = lower;
    int upper_index = upper;
    const int pivot = values[(lower + upper) / 2];

    while (lower_index <= upper_index)
    {
        while (values[lower_index] < pivot)
            lower_index++;
        while (values[upper_index] > pivot)
            upper_index--;
        if (lower_index <= upper_index)
            swap(&values[lower_index++], &values[upper_index--]);
    }

    if (lower < upper_index)
        quick_sort_range(values, lower, upper_index);
    if (lower_index < upper)
        quick_sort_range(values, lower_index, upper);
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

