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
void insertion_sort(int *array, int n);

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
    insertion_sort(array, ARRAY_LENGTH(array));
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

void insertion_sort(int *array, int n)
{
    for (int end = 1; end < n; end++)
    {
        int i = end;
        const int value = array[end];

        while (1 <= i && value < array[i - 1])
        {
            array[i] = array[i - 1];
            i--;
        }

        array[i] = value;
    }
}

