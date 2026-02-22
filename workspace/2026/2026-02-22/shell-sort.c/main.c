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
void shell_sort(int *array, int n);
int compute_initial_hop(int n);
void insert(int *array, int i, int hop);

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
    shell_sort(array, ARRAY_LENGTH(array));
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

void shell_sort(int *array, int n)
{
    for (int hop = compute_initial_hop(n); hop > 0; hop /= 3)
        for (int i = 1; i < n; i++)
            insert(array, i, hop);
}

int compute_initial_hop(int n)
{
    int hop = 1;

    while (hop * 3 + 1 < n)
        hop = hop * 3 + 1;

    return hop;
}

void insert(int *array, int i, int hop)
{
    int insertion_index = i;
    const int insertion_value = array[i];

    while (insertion_index >= hop && insertion_value < array[insertion_index - hop])
    {
        array[insertion_index] = array[insertion_index - hop];
        insertion_index -= hop;
    }

    array[insertion_index] = insertion_value;
}

