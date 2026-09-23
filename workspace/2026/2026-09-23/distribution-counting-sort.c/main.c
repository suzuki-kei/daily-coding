#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

void initialize(void);
void demonstration(void);
void set_random_values(int *array, int n, int begin, int end);
int random_range(int begin, int end);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void distribution_counting_sort(int *array, int n, int begin, int end);

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
    const int begin = 0;
    const int end = 9;

    int array[20];
    set_random_values(array, ARRAY_LENGTH(array), begin, end);
    print_array(array, ARRAY_LENGTH(array));
    distribution_counting_sort(array, ARRAY_LENGTH(array), begin, end);
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int n, int begin, int end)
{
    for (int i = 0; i < n; i++)
        array[i] = random_range(begin, end);
}

int random_range(int begin, int end)
{
    return rand() % (end - begin) + begin;
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

void distribution_counting_sort(int *array, int n, int begin, int end)
{
    int *buffer = NULL;
    int *counts = NULL;
    const int n_counts = end - begin;

    if ((buffer = malloc(n * sizeof(*buffer))) == NULL)
        goto FAILED;

    if ((counts = calloc(n_counts, sizeof(*counts))) == NULL)
        goto FAILED;

    for (int i = 0; i < n; i++)
        counts[array[i] - begin]++;

    for (int i = 1; i < n_counts; i++)
        counts[i] += counts[i - 1];

    for (int i = n - 1; i >= 0; i--)
        buffer[--counts[array[i] - begin]] = array[i];

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

