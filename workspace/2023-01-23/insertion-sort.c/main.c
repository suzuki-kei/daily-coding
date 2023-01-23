#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 20

void initialize();
void set_random_values(int *values, int size);
void print_values(const int *values, int size);
int is_sorted(const int *values, int size);
void insertion_sort(int *values, int size);
void swap(int *values, int index1, int index2);

int main(void)
{
    int values[SIZE];

    initialize();
    set_random_values(values, SIZE);
    print_values(values, SIZE);
    insertion_sort(values, SIZE);
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

int is_sorted(const int *values, int size)
{
    int i;

    for (i = 0; i < size - 1; i++)
        if (values[i] > values[i + 1])
            return 0;
    return 1;
}

void insertion_sort(int *values, int size)
{
    int i;
    int upper;

    for (upper = 1; upper < size; upper++)
        for (i = upper; i > 0 && values[i] < values[i - 1]; i--)
            swap(values, i, i - 1);
}

void swap(int *values, int index1, int index2)
{
    const int value1 = values[index1];
    values[index1] = values[index2];
    values[index2] = value1;
}

