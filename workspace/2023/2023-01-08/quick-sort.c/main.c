#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "quick-sort.h"

#define SIZE 20

void initialize();
void set_random_values(int *values, int size);
void print_values(const int *values, int size);
int is_sorted(const int *values, int size);

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

