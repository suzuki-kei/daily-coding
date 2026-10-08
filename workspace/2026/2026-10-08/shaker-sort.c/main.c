#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

void initialize(void);
void demonstration(void);
void set_random_values(int *array, int n, int value_begin, int value_end);
int random_range(int begin, int end);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void shaker_sort(int *array, int n);
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
    set_random_values(array, ARRAY_LENGTH(array), 10, 100);
    print_array(array, ARRAY_LENGTH(array));
    shaker_sort(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int n, int value_begin, int value_end)
{
    for (int i = 0; i < n; i++)
        array[i] = random_range(value_begin, value_end);
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

void shaker_sort(int *array, int n)
{
    int first = 0;
    int last = n - 1;

    while (first < last)
    {
        for (int i = first; i + 1 <= last; i++)
            if (array[i] > array[i + 1])
                swap(&array[i], &array[i + 1]);

        last--;

        for (int i = last; first <= i - 1; i--)
            if (array[i] < array[i - 1])
                swap(&array[i], &array[i - 1]);

        first++;
    }
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

