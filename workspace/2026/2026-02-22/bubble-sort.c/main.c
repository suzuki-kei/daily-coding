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
void bubble_sort(int *array, int n);
void swap(int *value1, int *value2);

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
    bubble_sort(array, ARRAY_LENGTH(array));
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

void bubble_sort(int *array, int n)
{
    for (int unsorted_size = n; unsorted_size > 1; unsorted_size--)
        for (int i = 0; i < unsorted_size - 1; i++)
            if (array[i] > array[i + 1])
                swap(&array[i], &array[i + 1]);
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

