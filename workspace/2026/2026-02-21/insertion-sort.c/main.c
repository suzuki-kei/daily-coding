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
void insertion_sort(int *array, int n);
void insert(int *array, int start_index);

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
    insertion_sort(array, ARRAY_LENGTH(array));
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

void insertion_sort(int *array, int n)
{
    for (int start_index = 1; start_index < n; start_index++)
        insert(array, start_index);
}

void insert(int *array, int start_index)
{
    int insertion_index = start_index;
    int insertion_value = array[start_index];

    while (insertion_index >= 1 && insertion_value < array[insertion_index - 1])
    {
        array[insertion_index] = array[insertion_index - 1];
        insertion_index--;
    }

    array[insertion_index] = insertion_value;
}

