#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

void initialize(void);
void demonstration(void);
void set_random_values(int *array, int n);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void merge_sort(int *array, int n);
void merge(int *output, const int *begin1, const int *end1, const int *begin2, const int *end2);
int min(int value1, int value2);
void swap(int **value1, int **value2);

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

    set_random_values(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
    merge_sort(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int n)
{
    for (int i = 0; i < n; i++)
        array[i] = rand() % 90 + 10;
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
    for (int i = 0; i < n - 1; i++)
        if (array[i] > array[i + 1])
            return 0;

    return 1;
}

void merge_sort(int *array, int n)
{
    if (n <= 1)
        return;

    int *buffer = NULL;

    if ((buffer = malloc(sizeof(int) * n)) == NULL)
    {
        fprintf(stderr, "allocation failed\n");
        exit(1);
    }

    int *source = array;
    int *target = buffer;

    for (int block_size = 1; block_size < n; block_size *= 2)
    {
        for (int offset = 0; offset < n; offset += block_size * 2)
        {
            merge(&target[offset],
                  &source[min(offset + block_size * 0, n)],
                  &source[min(offset + block_size * 1, n)],
                  &source[min(offset + block_size * 1, n)],
                  &source[min(offset + block_size * 2, n)]);
        }
        swap(&source, &target);
    }

    if (source != array)
        for (int i = 0; i < n; i++)
            array[i] = source[i];

    free(buffer);
}

void merge(int *output, const int *begin1, const int *end1, const int *begin2, const int *end2)
{
    while (begin1 != end1 && begin2 != end2)
        if (*begin1 <= *begin2)
            *output++ = *begin1++;
        else
            *output++ = *begin2++;

    while (begin1 != end1)
        *output++ = *begin1++;

    while (begin2 != end2)
        *output++ = *begin2++;
}

int min(int value1, int value2)
{
    if (value1 < value2)
        return value1;
    else
        return value2;
}

void swap(int **value1, int **value2)
{
    int * const temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

