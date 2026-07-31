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
void shell_sort(int *array, int n);
int compute_initial_gap(int n);
void insert(int *array, int i, int gap);

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

void shell_sort(int *array, int n)
{
    for (int gap = compute_initial_gap(n); gap >= 1; gap /= 3)
        for (int i = gap; i < n; i++)
            insert(array, i, gap);
}

int compute_initial_gap(int n)
{
    int gap = 1;

    while (gap * 3 + 1 < n)
        gap = gap * 3 + 1;

    return gap;
}

void insert(int *array, int i, int gap)
{
    const int value = array[i];

    while (i >= gap && value < array[i - gap])
    {
        array[i] = array[i - gap];
        i -= gap;
    }

    array[i] = value;
}

