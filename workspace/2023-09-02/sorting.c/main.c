#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "sorting.h"

#define SIZE 20

typedef void (*sort_fn)(int *values, int size);

void initialize();
void demonstration(const char *description, sort_fn sort);
void set_random_values(int *values, int size);
void print_values(const int *values, int size);
int is_sorted(const int *values, int size);

#define DEMONSTRATION(name) \
    demonstration(#name, name)

int main(void)
{
    initialize();

    DEMONSTRATION(bubble_sort);
    DEMONSTRATION(insertion_sort);
    DEMONSTRATION(selection_sort);
    DEMONSTRATION(quick_sort);

    return 0;
}

void demonstration(const char *description, sort_fn sort)
{
    int values[SIZE];

    printf("==== %s\n", description);
    set_random_values(values, SIZE);
    print_values(values, SIZE);
    sort(values, SIZE);
    print_values(values, SIZE);
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

