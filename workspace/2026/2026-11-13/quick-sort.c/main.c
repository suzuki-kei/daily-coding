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

typedef Range (*FnPartition)(int *array, int begin, int end);

void initialize(void);
void demonstrate(const char *label, FnPartition partition);
void set_random_values(int *array, int n, int begin_value, int end_value);
int random_range(int begin, int end);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void quick_sort(int *array, int n, FnPartition partition);
void quick_sort_range(int *array, int begin, int end, FnPartition partition);
Range partition_2way(int *array, int begin, int end);
Range partition_3way(int *array, int begin, int end);
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
    set_random_values(array, ARRAY_LENGTH(array), 10, 100);
    print_array(array, ARRAY_LENGTH(array));
    quick_sort(array, ARRAY_LENGTH(array), partition);
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int n, int begin_value, int end_value)
{
    for (int i = 0; i < n; i++)
        array[i] = random_range(begin_value, end_value);
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

void quick_sort(int *array, int n, FnPartition partition)
{
    quick_sort_range(array, 0, n, partition);
}

void quick_sort_range(int *array, int begin, int end, FnPartition partition)
{
    while (begin < end - 1)
    {
        const Range middle = partition(array, begin, end);
        const int left_count = middle.begin - begin;
        const int right_count = end - middle.end;

        if (left_count < right_count)
        {
            quick_sort_range(array, begin, middle.begin, partition);
            begin = middle.end;
        }
        else
        {
            quick_sort_range(array, middle.end, end, partition);
            end = middle.begin;
        }
    }
}

Range partition_2way(int *array, int begin, int end)
{
    int increasing_index = begin;
    int decreasing_index = end - 1;
    const int pivot = array[random_range(begin, end)];

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

Range partition_3way(int *array, int begin, int end)
{
    int i = begin;
    int less_end = begin;
    int greater_begin = end;
    const int pivot = array[random_range(begin, end)];

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

