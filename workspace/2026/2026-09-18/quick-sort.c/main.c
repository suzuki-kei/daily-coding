#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

typedef struct
{
    int left_end;
    int right_begin;
}
PartitionResult;

typedef PartitionResult (*FnPartition)(int *array, int begin, int end);

void initialize(void);
void demonstration(void);
void demonstration_step(const char *label, FnPartition partition);
void set_random_values(int *array, int n, int begin, int end);
int random_range(int begin, int end);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void quick_sort(int *array, int n, FnPartition partition);
void quick_sort_range(int *array, int begin, int end, FnPartition partition);
PartitionResult partition_2way(int *array, int begin, int end);
PartitionResult partition_3way(int *array, int begin, int end);
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
    set_random_values(array, ARRAY_LENGTH(array), 10, 99);
    print_array(array, ARRAY_LENGTH(array));
    quick_sort(array, ARRAY_LENGTH(array), partition);
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int n, int begin, int end)
{
    for (int i = 0; i < n; i++)
        array[i] = random_range(begin, end);
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
    while (begin < end)
    {
        const PartitionResult result = partition(array, begin, end);
        const int n_left = result.left_end - begin;
        const int n_right = end - result.right_begin;

        if (n_left <= n_right)
        {
            quick_sort_range(array, begin, result.left_end, partition);
            begin = result.right_begin;
        }
        else
        {
            quick_sort_range(array, result.right_begin, end, partition);
            end = result.left_end;
        }
    }
}

PartitionResult partition_2way(int *array, int begin, int end)
{
    int i = begin;
    int j = end;
    const int pivot = array[random_range(begin, end)];

    while (i < j)
    {
        while (array[i] < pivot)
            i++;

        while (array[j - 1] > pivot)
            j--;

        if (i < j)
            swap(&array[i++], &array[--j]);
    }

    return (PartitionResult) {
        .left_end = j,
        .right_begin = i,
    };
}

PartitionResult partition_3way(int *array, int begin, int end)
{
    int i = begin;
    int less_end = begin;
    int greater_begin = end;
    const int pivot = array[random_range(begin, end)];

    while (i < greater_begin)
        if (array[i] < pivot)
            swap(&array[less_end++], &array[i++]);
        else if (array[i] > pivot)
            swap(&array[i], &array[--greater_begin]);
        else
            i++;

    return (PartitionResult) {
        .left_end = less_end,
        .right_begin = greater_begin,
    };
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

