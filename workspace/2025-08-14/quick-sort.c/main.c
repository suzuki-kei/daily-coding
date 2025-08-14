#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

typedef void (*FnPartition)(int *array, int lower, int upper, int *left_upper, int *right_lower);

void initialize(void);
void demonstration(void);
void set_random_values(int *array, int size);
void print_array(const int *array, int size);
int is_sorted(const int *array, int size);
void quick_sort(FnPartition partition, int *array, int size);
void quick_sort_range(FnPartition partition, int *array, int lower, int upper);
void partition_2way(int *array, int lower, int upper, int *left_upper, int *right_lower);
void partition_3way(int *array, int lower, int upper, int *left_upper, int *right_lower);
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

    printf("==== 2-way partition\n");
    set_random_values(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
    quick_sort(partition_2way, array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));

    printf("==== 3-way partition\n");
    set_random_values(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
    quick_sort(partition_3way, array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int size)
{
    int i;

    for (i = 0; i < size; i++)
        array[i] = rand() % 90 + 10;
}

void print_array(const int *array, int size)
{
    int i;
    const char *separator = "";

    for (i = 0; i < size; i++)
    {
        printf("%s%d", separator, array[i]);
        separator = " ";
    }

    if (is_sorted(array, size))
        printf(" (sorted)\n");
    else
        printf(" (not sorted)\n");
}

int is_sorted(const int *array, int size)
{
    int i;

    for (i = 0; i < size - 1; i++)
        if (array[i] > array[i + 1])
            return 0;

    return 1;
}

void quick_sort(FnPartition partition, int *array, int size)
{
    if (size <= 1)
        return;

    quick_sort_range(partition, array, 0, size - 1);
}

void quick_sort_range(FnPartition partition, int *array, int lower, int upper)
{
    int left_upper;
    int right_lower;

    partition(array, lower, upper, &left_upper, &right_lower);

    if (lower < left_upper)
        quick_sort_range(partition, array, lower, left_upper);
    if (right_lower < upper)
        quick_sort_range(partition, array, right_lower, upper);
}

void partition_2way(int *array, int lower, int upper, int *left_upper, int *right_lower)
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

    *left_upper = decrement_index;
    *right_lower = increment_index;
}

void partition_3way(int *array, int lower, int upper, int *left_upper, int *right_lower)
{
    int low = lower;
    int mid = lower;
    int high = upper;
    const int pivot = random_select(array, lower, upper);

    while (mid <= high)
    {
        if (array[mid] < pivot)
            swap(&array[low++], &array[mid++]);
        else if (array[mid] > pivot)
            swap(&array[mid], &array[high--]);
        else
            mid++;
    }

    *left_upper = low - 1;
    *right_lower = mid;
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

