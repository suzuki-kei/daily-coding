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

typedef Range (*FnPartition)(int *array, Range range);

void initialize(void);
void demonstrate(const char *label, FnPartition partition);
void set_random_values(int *array, int n, Range value_range);
int random_range(Range range);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void quick_sort(int *array, int n, FnPartition partition);
void quick_sort_range(int *array, Range range, FnPartition partition);
Range partition_2way(int *array, Range range);
Range partition_3way(int *array, Range range);
void swap(int *value1, int *value2);

int main(void)
{
    initialize();
    demonstrate("partition 2-way", partition_2way);
    demonstrate("partition 3-way", partition_3way);
    return 0;
}

void initialize(void)
{
    srand(time(NULL));
}

void demonstrate(const char *label, FnPartition partition)
{
    printf("==== %s\n", label);

    int array[20];
    const Range value_range = { 10, 100 };
    set_random_values(array, ARRAY_LENGTH(array), value_range);
    print_array(array, ARRAY_LENGTH(array));
    quick_sort(array, ARRAY_LENGTH(array), partition);
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

void quick_sort(int *array, int n, FnPartition partition)
{
    quick_sort_range(array, (Range) { 0, n }, partition);
}

void quick_sort_range(int *array, Range range, FnPartition partition)
{
    while (range.begin < range.end - 1)
    {
        const Range middle = partition(array, range);
        const int left_count = middle.begin - range.begin;
        const int right_count = range.end - middle.end;

        if (left_count < right_count)
        {
            quick_sort_range(array, (Range) { range.begin, middle.begin }, partition);
            range.begin = middle.end;
        }
        else
        {
            quick_sort_range(array, (Range) { middle.end, range.end }, partition);
            range.end = middle.begin;
        }
    }
}

Range partition_2way(int *array, Range range)
{
    int increasing_index = range.begin;
    int decreasing_index = range.end - 1;
    const int pivot = array[random_range(range)];

    while (increasing_index <= decreasing_index)
    {
        while (array[increasing_index] < pivot)
            increasing_index++;

        while (array[decreasing_index] > pivot)
            decreasing_index--;

        if (increasing_index <= decreasing_index)
            swap(&array[increasing_index++], &array[decreasing_index--]);
    }

    return (Range) {
        .begin = decreasing_index + 1,
        .end = increasing_index,
    };
}

Range partition_3way(int *array, Range range)
{
    int i = range.begin;
    int less_end = range.begin;
    int greater_begin = range.end;
    const int pivot = array[random_range(range)];

    while (i < greater_begin)
    {
        if (array[i] < pivot)
            swap(&array[less_end++], &array[i++]);
        else if (array[i] > pivot)
            swap(&array[i], &array[--greater_begin]);
        else
            i++;
    }

    return (Range) {
        .begin = less_end,
        .end = greater_begin,
    };
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

