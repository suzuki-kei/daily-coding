#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <limits.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

#define MIN 10
#define MAX 99

void initialize(void);
void demonstration(void);
void set_random_values(int *array, size_t n, int min, int max);
int random_range(int min, int max);
void print_array(const int *array, size_t n);
int is_sorted(const int *array, size_t n);
void counting_sort(int *array, int n, int min, int max);

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
    int array[20];
    set_random_values(array, ARRAY_LENGTH(array), MIN, MAX);
    print_array(array, ARRAY_LENGTH(array));
    counting_sort(array, ARRAY_LENGTH(array), MIN, MAX);
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, size_t n, int min, int max)
{
    for (size_t i = 0; i < n; i++)
        array[i] = random_range(min, max);
}

int random_range(int min, int max)
{
    return rand() % (max - min + 1) + min;
}

void print_array(const int *array, size_t n)
{
    const char *separator = "";

    for (size_t i = 0; i < n; i++)
    {
        printf("%s%d", separator, array[i]);
        separator = " ";
    }

    if (is_sorted(array, n))
        printf(" (sorted)\n");
    else
        printf(" (not sorted)\n");
}

int is_sorted(const int *array, size_t n)
{
    for (size_t i = 0; i + 1 < n; i++)
        if (array[i] > array[i + 1])
            return 0;

    return 1;
}

void counting_sort(int *array, int n, int min, int max)
{
    int n_counts = max - min + 1;
    int *counts = NULL;

    if ((counts = malloc(sizeof(int) * n_counts)) == NULL)
    {
        fprintf(stderr, "allocation failed.\n");
        exit(1);
    }

    for (int i = 0; i < n_counts; i++)
        counts[i] = 0;

    for (int i = 0; i < n; i++)
        counts[array[i] - min]++;

    int i_array = 0;

    for (int i_counts = 0; i_counts < n_counts; i_counts++)
        for (int i = 0; i < counts[i_counts]; i++)
            array[i_array++] = i_counts + min;

    free(counts);
}

