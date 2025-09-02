#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

typedef struct
{
    int left_upper;
    int right_lower;
}
PartitionResult;

typedef PartitionResult (*FnPartition)(int *array, int lower, int upper);

void initialize(void);
void demonstration(void);
void set_random_values(int *array, int n);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void quick_sort(int *array, int n, FnPartition partition);
void quick_sort_range(int *array, int lower, int upper, FnPartition partition);
PartitionResult partition_2way(int *array, int lower, int upper);
PartitionResult partition_3way(int *array, int lower, int upper);
int random_select(const int *array, int lower, int upper);
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

    printf("==== partition 2-way\n");
    set_random_values(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
    quick_sort(array, ARRAY_LENGTH(array), partition_2way);
    print_array(array, ARRAY_LENGTH(array));

    printf("==== partition 3-way\n");
    set_random_values(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
    quick_sort(array, ARRAY_LENGTH(array), partition_3way);
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int n)
{
    int i;

    for (i = 0; i < n; i++)
        array[i] = rand() % 90 + 10;
}

void print_array(const int *array, int n)
{
    int i;
    const char *separator = "";

    for (i = 0; i < n; i++)
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
    int i;

    for (i = 0; i < n - 1; i++)
        if (array[i] > array[i + 1])
            return 0;

    return 1;
}

void quick_sort(int *array, int n, FnPartition partition)
{
    quick_sort_range(array, 0, n - 1, partition);
}

void quick_sort_range(int *array, int lower, int upper, FnPartition partition)
{
    if (lower < upper)
    {
        const PartitionResult result = partition(array, lower, upper);
        quick_sort_range(array, lower, result.left_upper, partition);
        quick_sort_range(array, result.right_lower, upper, partition);
    }
}

PartitionResult partition_2way(int *array, int lower, int upper)
{
    int increment_index = lower;
    int decrement_index = upper;
    const int pivot = random_select(array, lower, upper);

    while (increment_index <= decrement_index)
    {
        while (array[increment_index] < pivot)
            increment_index++;

        while (array[decrement_index] > pivot)
            decrement_index--;

        if (increment_index <= decrement_index)
            swap(&array[increment_index++], &array[decrement_index--]);
    }

    const PartitionResult result =
    {
        decrement_index,
        increment_index,
    };

    return result;
}

PartitionResult partition_3way(int *array, int lower, int upper)
{
    int less_end = lower;
    int increment_index = lower;
    int decrement_index = upper;
    const int pivot = random_select(array, lower, upper);

    while (increment_index <= decrement_index)
    {
        if (array[increment_index] < pivot)
            swap(&array[less_end++], &array[increment_index++]);
        else if (array[increment_index] > pivot)
            swap(&array[increment_index], &array[decrement_index--]);
        else
            increment_index++;
    }

    const PartitionResult result =
    {
        less_end - 1,
        increment_index,
    };

    return result;
}

int random_select(const int *array, int lower, int upper)
{
    return array[rand() % (upper - lower + 1) + lower];
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

