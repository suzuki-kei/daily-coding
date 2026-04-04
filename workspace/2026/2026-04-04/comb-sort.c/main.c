#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

void initialize(void);
void demonstration(void);
void set_random_values(int *array, int n);
int random_range(int lower, int upper);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void comb_sort(int *array, int n);
int compute_next_gap(int gap);
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
    comb_sort(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int n)
{
    for (int i = 0; i < n; i++)
        array[i] = random_range(10, 99);
}

int random_range(int lower, int upper)
{
    return rand() % (upper - lower + 1) + lower;
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

void comb_sort(int *array, int n)
{
    int gap = n;
    int done = 0;

    while (gap > 1 || !done)
    {
        gap = compute_next_gap(gap);
        done = 1;

        for (int i = 0; i + gap < n; i++)
        {
            if (array[i] > array[i + gap])
            {
                swap(&array[i], &array[i + gap]);
                done = 0;
            }
        }
    }
}

int compute_next_gap(int gap)
{
    if (gap <= 2)
        return 1;

    if (gap == 9 || gap == 10)
        return 13;

    return gap * 10 / 13;
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

