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
void heap_sort(int *array, int n);
void heap_build(int *array, int n);
void heap_pop_all(int *array, int n);
void heap_pop(int *array, int n);
void heap_shift_down(int *array, int n, int i);
void swap(int *value1, int *value2);

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
    heap_sort(array, ARRAY_LENGTH(array));
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

void heap_sort(int *array, int n)
{
    heap_build(array, n);
    heap_pop_all(array, n);
}

void heap_build(int *array, int n)
{
    for (int i = n / 2 - 1; 0 <= i; i--)
        heap_shift_down(array, n, i);
}

void heap_pop_all(int *array, int n)
{
    for (int end = n; 1 < end; end--)
        heap_pop(array, end);
}

void heap_pop(int *array, int n)
{
    swap(&array[n - 1], &array[0]);
    heap_shift_down(array, n - 1, 0);
}

void heap_shift_down(int *array, int n, int i)
{
    while (i * 2 + 1 < n)
    {
        int maximum_index = i;
        const int left_index = i * 2 + 1;
        const int right_index = i * 2 + 2;

        if (left_index < n && array[left_index] > array[maximum_index])
            maximum_index = left_index;

        if (right_index < n && array[right_index] > array[maximum_index])
            maximum_index = right_index;

        if (i == maximum_index)
            break;

        swap(&array[i], &array[maximum_index]);
        i = maximum_index;
    }
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

