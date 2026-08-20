#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

void initialize(void);
void demonstration(void);
void set_random_values(int *array, int n, int min, int max);
int random_range(int min, int max);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void inverse_mapping_sort(int *array, int n, int min, int max);

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
    int min = 0;
    int max = 9;
    int array[20];
    set_random_values(array, ARRAY_LENGTH(array), min, max);
    print_array(array, ARRAY_LENGTH(array));
    inverse_mapping_sort(array, ARRAY_LENGTH(array), min, max);
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int n, int min, int max)
{
    for (int i = 0; i < n; i++)
        array[i] = random_range(min, max);
}

int random_range(int min, int max)
{
    return rand() % (max - min + 1) + min;
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

void inverse_mapping_sort(int *array, int n, int min, int max)
{
    int *buffer = NULL;
    int *first_indexes = NULL;
    int *next_indexes  = NULL;
    const int n_first_indexes = max - min + 1;

    if ((buffer = malloc(n * sizeof(*buffer))) == NULL)
        goto FAILED;

    if ((first_indexes = malloc(n_first_indexes * sizeof(*first_indexes))) == NULL)
        goto FAILED;

    if ((next_indexes = malloc(n * sizeof(*next_indexes))) == NULL)
        goto FAILED;

    for (int i = 0; i < n_first_indexes; i++)
        first_indexes[i] = -1;

    for (int i = n - 1; i >= 0; i--)
    {
        const int value_with_offset = array[i] - min;
        next_indexes[i] = first_indexes[value_with_offset];
        first_indexes[value_with_offset] = i;
    }

    int i_buffer = 0;

    for (int value = min; value <= max; value++)
    {
        const int value_with_offset = value - min;

        for (int i = first_indexes[value_with_offset]; i >= 0; i = next_indexes[i])
            buffer[i_buffer++] = array[i];
    }

    for (int i = 0; i < n; i++)
        array[i] = buffer[i];

    free(buffer);
    free(first_indexes);
    free(next_indexes);
    return;

FAILED:
    free(buffer);
    free(first_indexes);
    free(next_indexes);
    fprintf(stderr, "allocation failed.\n");
    exit(1);
}

