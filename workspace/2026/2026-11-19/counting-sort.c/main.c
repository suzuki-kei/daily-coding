#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

typedef struct
{
    int begin;
    int end;
}
Range;

void initialize(void);
void demonstrate(void);
void set_random_values(int *array, int n, Range value_range);
int random_range(Range range);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void counting_sort(int *array, int n, Range value_range);

int main(void)
{
    initialize();
    demonstrate();
    return 0;
}

void initialize(void)
{
    srand(time(NULL));
}

void demonstrate(void)
{
    int array[20];
    const Range value_range = { 0, 10 };
    set_random_values(array, ARRAY_LENGTH(array), value_range);
    print_array(array, ARRAY_LENGTH(array));
    counting_sort(array, ARRAY_LENGTH(array), value_range);
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int n, Range value_range)
{
    for (int i = 0; i < n; i++)
        array[i] = random_range(value_range);
}

int random_range(Range range)
{
    return rand() % (range.end - range.begin) + range.begin;
}

void print_array(const int *array, int n)
{
    const char *separator = "";

    for (int i = 0; i < n; i++)
    {
        printf("%s%d", separator, array[i]);
        separator = " ";
    }

    if (is_sorted(array, n))
        printf(" (sorted)\n");
    else
        printf(" (not sorted)\n");
}

int is_sorted(const int *array, int n)
{
    for (int i = 0; i + 1 < n; i++)
        if (array[i] > array[i + 1])
            return 0;

    return 1;
}

void counting_sort(int *array, int n, Range value_range)
{
    int *counts = NULL;
    const int n_counts = value_range.end - value_range.begin;

    if ((counts = calloc(n_counts, sizeof(*counts))) == NULL)
    {
        fprintf(stderr, "allocation failed.\n");
        exit(1);
    }

    for (int i = 0; i < n; i++)
        counts[array[i] - value_range.begin]++;

    int output_index = 0;

    for (int counts_index = 0; counts_index < n_counts; counts_index++)
        for (int i = 0; i < counts[counts_index]; i++)
            array[output_index++] = counts_index + value_range.begin;

    free(counts);
}

