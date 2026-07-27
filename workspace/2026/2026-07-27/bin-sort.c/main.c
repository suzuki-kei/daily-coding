#include <stdio.h>
#include <stdlib.h>
#include <time.h>

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
void bin_sort(int *array, size_t n, int min, int max);

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
    bin_sort(array, ARRAY_LENGTH(array), MIN, MAX);
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

void bin_sort(int *array, size_t n, int min, int max)
{
    size_t *bins = NULL;
    const size_t n_bins = max - min + 1;

    if ((bins = malloc(sizeof(size_t) * n_bins)) == NULL)
    {
        fprintf(stderr, "allocation failed.\n");
        exit(1);
    }

    for (size_t i = 0; i < n_bins; i++)
        bins[i] = 0;

    for (size_t i = 0; i < n; i++)
        bins[array[i] - min]++;

    size_t i_array = 0;

    for (size_t i_bins = 0; i_bins < n_bins; i_bins++)
        for (size_t i = 0; i < bins[i_bins]; i++)
            array[i_array++] = i_bins + min;

    free(bins);
    bins = NULL;
}

