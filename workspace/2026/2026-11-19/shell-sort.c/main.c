#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

typedef struct
{
    int begin;
    int end;
}
Range;

void initialize(void);
void demonstrate(void);
void set_random_values(int *array, int n, Range value_range);
int random_range(Range range);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void shell_sort(int *array, int n);
int to_initial_gap(int n);

int main(void)
{
    initialize();
    demonstrate();
    return 0;
}

void initialize(void)
{
    srand(time(NULL));
}

void demonstrate(void)
{
    int array[20];
    const Range value_range = { 10, 100 };
    set_random_values(array, ARRAY_LENGTH(array), value_range);
    print_array(array, ARRAY_LENGTH(array));
    shell_sort(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int n, Range value_range)
{
    for (int i = 0; i < n; i++)
        array[i] = random_range(value_range);
}

int random_range(Range range)
{
    return rand() % (range.end - range.begin) + range.begin;
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
    for (int gap = to_initial_gap(n); 1 <= gap; gap /= 3)
    {
        for (int end = gap; end < n; end++)
        {
            int i = end;
            const int value = array[end];

            while (gap <= i && value < array[i - gap])
            {
                array[i] = array[i - gap];
                i -= gap;
            }

            array[i] = value;
        }
    }
}

int to_initial_gap(int n)
{
    int gap = 1;

    while (gap * 3 + 1 < n)
        gap = gap * 3 + 1;

    return gap;
}

