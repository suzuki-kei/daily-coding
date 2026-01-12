#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "sorting-algorithm.h"

#define SIZE 20

#define DEMONSTRATION(sorting_algorithm)            \
    {                                               \
        int values[SIZE];                           \
        printf("==== %s\n", #sorting_algorithm);    \
        set_random_values(values, SIZE);            \
        print_values(values, SIZE);                 \
        sorting_algorithm(values, SIZE);            \
        print_values(values, SIZE);                 \
    }

void initialize();
void demonstration();
void set_random_values(int *values, int size);
void print_values(const int *values, int size);
int is_sorted(const int *values, int size);

int main(void)
{
    initialize();
    demonstration();

    return 0;
}

void demonstration()
{
    DEMONSTRATION(bubble_sort);
    DEMONSTRATION(insertion_sort);
    DEMONSTRATION(quick_sort);
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

