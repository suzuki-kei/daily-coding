#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

typedef struct
{
    int left_last;
    int right_first;
}
PartitionResult;

typedef PartitionResult (*FnPartition)(int *array, int first, int last);

void initialize(void);
void demonstration(void);
void demonstration_step(const char *label, FnPartition partition);
void set_random_values(int *array, int n);
int random_range(int min, int max);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void quick_sort(int *array, int n, FnPartition partition);
void quick_sort_range(int *array, int first, int last, FnPartition partition);
PartitionResult partition_2way(int *array, int first, int last);
PartitionResult partition_3way(int *array, int first, int last);
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
    demonstration_step("partition 2-way", partition_2way);
    demonstration_step("partition 3-way", partition_3way);
}

void demonstration_step(const char *label, FnPartition partition)
{
    printf("==== %s\n", label);

    int array[20];
    set_random_values(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
    quick_sort(array, ARRAY_LENGTH(array), partition);
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

void quick_sort(int *array, int n, FnPartition partition)
{
    quick_sort_range(array, 0, n - 1, partition);
}

void quick_sort_range(int *array, int first, int last, FnPartition partition)
{
    while (first < last)
    {
        const PartitionResult result = partition(array, first, last);
        const int left_size = result.left_last - first + 1;
        const int right_size = last - result.right_first + 1;

        if (left_size <= right_size)
        {
            quick_sort_range(array, first, result.left_last, partition);
            first = result.right_first;
        }
        else
        {
            quick_sort_range(array, result.right_first, last, partition);
            last = result.left_last;
        }
    }
}

PartitionResult partition_2way(int *array, int first, int last)
{
    int increment_index = first;
    int decrement_index = last;
    const int pivot = array[random_range(first, last)];

    while (increment_index <= decrement_index)
    {
        while (array[increment_index] < pivot)
            increment_index++;

        while (array[decrement_index] > pivot)
            decrement_index--;

        if (increment_index <= decrement_index)
            swap(&array[increment_index++], &array[decrement_index--]);
    }

    return (PartitionResult) {
        .left_last = decrement_index,
        .right_first = increment_index,
    };
}

PartitionResult partition_3way(int *array, int first, int last)
{
    int less_end = first;
    int increment_index = first;
    int decrement_index = last;
    const int pivot = array[random_range(first, last)];

    while (increment_index <= decrement_index)
    {
        if (array[increment_index] < pivot)
            swap(&array[less_end++], &array[increment_index++]);
        else if (array[increment_index] > pivot)
            swap(&array[increment_index], &array[decrement_index--]);
        else
            increment_index++;
    }

    return (PartitionResult) {
        .left_last = less_end - 1,
        .right_first = increment_index,
    };
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

