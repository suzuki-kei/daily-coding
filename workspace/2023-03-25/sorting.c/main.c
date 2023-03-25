#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "main.h"

int main(void)
{
    initialize();
    DEMONSTRATION(insertion_sort);
    DEMONSTRATION(selection_sort);
    DEMONSTRATION(quick_sort);
    return 0;
}

void initialize()
{
    srand(time(NULL));
}

void demonstration(const char *name, sorting_fn sorting)
{
    int values[SIZE];

    printf("==== %s\n", name);
    set_random_values(values, SIZE);
    print_values(values, SIZE);
    sorting(values, SIZE);
    print_values(values, SIZE);
}

void set_random_values(int *values, int size)
{
    int i;

    for (i = 0; i < size; i++)
        values[i] = rand() % 90 + 10;
}

void print_values(int *values, int size)
{
    int i;

    for (i = 0; i < size; i++)
        printf("%d ", values[i]);

    if (is_sorted(values, size))
        printf("(sorted)\n");
    else
        printf("(not sorted)\n");
}

int is_sorted(int *values, int size)
{
    int i;

    for (i = 0; i < size - 1; i++)
        if (values[i] > values[i + 1])
            return 0;
    return 1;
}

