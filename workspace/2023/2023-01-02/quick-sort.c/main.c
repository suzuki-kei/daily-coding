#include "main.h"
#include "quick-sort.h"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void)
{
    demonstration();
    test(set_random_values);

    return 0;
}

void initialize()
{
    srand(time(NULL));
}

void demonstration()
{
    const int size = 20;
    const int verbose = 1;
    _test(size, set_random_values, verbose);
}

void test(set_values_t set_values)
{
    const int sizes[] = {
        0,
        1,
        2,
        3,
        10,
        100,
        1000,
    };
    const set_values_t set_values_functions[] = {
        set_random_values,
        set_constant_values,
        set_ascending_values,
        set_descending_values,
    };
    const int verbose = 0;

    int i, j;

    for (j = 0; j < ARRAY_LENGTH(set_values_functions); j++)
        for (i = 0; i < ARRAY_LENGTH(sizes); i++)
            _test(sizes[i], set_values_functions[j], verbose);
}

void _test(int size, set_values_t set_values, int verbose)
{
    int *values = malloc(sizeof(int) * size);
    int *sorted_values = malloc(sizeof(int) * size);

    set_values(values, size);
    copy_values(values, sorted_values, size);
    quick_sort(sorted_values, size);

    if (!is_sorted(sorted_values, size))
    {
        printf("test failed:\n");
        print_values("    before : ", values, size);
        print_values("    after  : ", sorted_values, size);
    }
    else if (verbose)
    {
        print_values("    before : ", values, size);
        print_values("    after  : ", sorted_values, size);
    }

    free(sorted_values);
}

void copy_values(const int *source, int *destination, int size)
{
    int i;

    for (i = 0; i < size; i++)
        destination[i] = source[i];
}

void print_values(const char *description, const int *values, int size)
{
    int i;

    printf("%s", description);

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

void set_random_values(int *values, int size)
{
    int i;

    for (i = 0; i < size; i++)
        values[i] = rand() % 90 + 10;
}

void set_constant_values(int *values, int size)
{
    int i;

    for (i = 0; i < size; i++)
        values[i] = 0;
}

void set_ascending_values(int *values, int size)
{
    int i;

    for (i = 0; i < size; i++)
        values[i] = i + 10;
}

void set_descending_values(int *values, int size)
{
    int i;

    for (i = 0; i < size; i++)
        values[size - i - 1] = i + 10;
}

