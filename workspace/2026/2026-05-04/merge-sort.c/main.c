#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

void initialize(void);
void demonstration(void);
void set_random_values(int *array, int n);
int random_range(int min, int max);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void merge_sort(int *array, int n);
int min(int value1, int value2);
void merge(int *output, const int *begin1, const int *end1, const int *begin2, const int *end2);
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
        array[i] = random_range(10, 99);
}

int random_range(int min, int max)
{
    return rand() % (max - min + 1) + min;
}

void print_array(const int *array, int n)
{
    const char *separator = "";

    for (int i = 0; i < n; i++)
        printf("%s%d", separator, array[i]),
        separator = " ";

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

void merge_sort(int *array, int n)
{
    int *buffer = NULL;

    if ((buffer = malloc(sizeof(int) * n)) == NULL)
        fprintf(stderr, "allocation failed.\n"),
        exit(1);

    int *input = array;
    int *output = buffer;

    for (int chunk_size = 1; chunk_size < n; chunk_size *= 2)
    {
        for (int i = 0; i < n; i += chunk_size * 2)
        {
            merge(
                &output[i],
                &input[i],
                &input[min(n, i + chunk_size)],
                &input[min(n, i + chunk_size)],
                &input[min(n, i + chunk_size * 2)]);
        }

        swap(&input, &output);
    }

    if (array == output)
        for (int i = 0; i < n; i++)
            array[i] = buffer[i];

    free(buffer);
    buffer = NULL;
}

int min(int value1, int value2)
{
    if (value1 <= value2)
        return value1;
    else
        return value2;
}

void merge(int *output, const int *begin1, const int *end1, const int *begin2, const int *end2)
{
    while (begin1 != end1 && begin2 != end2)
    {
        if (*begin1 <= *begin2)
            *output++ = *begin1++;
        else
            *output++ = *begin2++;
    }

    while (begin1 != end1)
        *output++ = *begin1++;

    while (begin2 != end2)
        *output++ = *begin2++;
}

void swap(int **value1, int **value2)
{
    int * const temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

