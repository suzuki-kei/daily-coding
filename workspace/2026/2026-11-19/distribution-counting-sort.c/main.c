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
void distribution_counting_sort(int *array, int n, Range value_range);

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
    distribution_counting_sort(array, ARRAY_LENGTH(array), value_range);
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

void distribution_counting_sort(int *array, int n, Range value_range)
{
    int *buffer = NULL;
    int *counts = NULL;
    const int n_counts = value_range.end - value_range.begin;

    if ((buffer = malloc(n * sizeof(*buffer))) == NULL)
        goto FAILED;

    if ((counts = calloc(n_counts, sizeof(*counts))) == NULL)
        goto FAILED;

    for (int i = 0; i < n; i++)
        counts[array[i] - value_range.begin]++;

    for (int i = 1; i < n_counts; i++)
        counts[i] += counts[i - 1];

    for (int i = n - 1; 0 <= i; i--)
        buffer[--counts[array[i] - value_range.begin]] = array[i];

    for (int i = 0; i < n; i++)
        array[i] = buffer[i];

    free(buffer);
    free(counts);
    return;

FAILED:
    free(buffer);
    free(counts);
    fprintf(stderr, "allocation failed.\n");
    exit(1);
}

