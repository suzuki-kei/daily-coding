#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>

//#define DEBUG

#ifdef DEBUG
#define DATA_SIZE 20
#define ITERATION_SIZE 1
#define MODULO_IN_RANDOM_VALUE 4
#else
#define DATA_SIZE 65536
#define ITERATION_SIZE 1000
#define MODULO_IN_RANDOM_VALUE 20
#endif

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

struct SortAlgorithm
{
    const char *name;
    void (*function)(int *array, int size);
};

#define SORT_ALGORITHM(name) \
    {#name, name}

struct SetValuesAlgorithm
{
    const char *name;
    void (*function)(int *array, int size);
};

#define SET_VALUES_ALGORITHM(name) \
    {#name, set_ ## name}

void initialize(void);
void demonstration(void);
void demonstration_one(const struct SortAlgorithm *sort_algorithm, const struct SetValuesAlgorithm *set_values_algorithm);
void set_constant_values(int *array, int size);
void set_ascending_values(int *array, int size);
void set_descending_values(int *array, int size);
void set_random_values(int *array, int size);
void print_array(const int *array, int size);
int is_sorted(const int *array, int size);
void quick_sort_2way_partition(int *array, int size);
void quick_sort_2way_partition_range(int *array, int lower, int upper);
void quick_sort_3way_partition(int *array, int size);
void quick_sort_3way_partition_range(int *array, int lower, int upper);
void swap(int *value1, int *value2);
int random_index(int lower, int upper);
int random_select(const int *array, int lower, int upper);

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
    const struct SortAlgorithm sort_algorithms[] = {
        SORT_ALGORITHM(quick_sort_2way_partition),
        SORT_ALGORITHM(quick_sort_3way_partition),
    };

    const struct SetValuesAlgorithm set_values_algorithms[] = {
        SET_VALUES_ALGORITHM(constant_values),
        SET_VALUES_ALGORITHM(ascending_values),
        SET_VALUES_ALGORITHM(descending_values),
        SET_VALUES_ALGORITHM(random_values),
    };

    int i, j;

    printf("DATA_SIZE=%d\n", DATA_SIZE);
    printf("ITERATION_SIZE=%d\n", ITERATION_SIZE);
    printf("MODULO_IN_RANDOM_VALUE=%d\n", MODULO_IN_RANDOM_VALUE);
    printf("RAND_MAX=%d\n", RAND_MAX);
    printf("\n");

    for (i = 0; i < ARRAY_LENGTH(sort_algorithms); i++)
        for (j = 0; j < ARRAY_LENGTH(set_values_algorithms); j++)
            demonstration_one(&sort_algorithms[i], &set_values_algorithms[j]);
}

void demonstration_one(
    const struct SortAlgorithm *sort_algorithm,
    const struct SetValuesAlgorithm *set_values_algorithm)
{
    int array[DATA_SIZE];
    const clock_t start_time = clock();

    printf("%s (%s)\n", sort_algorithm->name, set_values_algorithm->name);

    for (int i = 0; i < ITERATION_SIZE; i++)
    {
        set_values_algorithm->function(array, ARRAY_LENGTH(array));
        print_array(array, ARRAY_LENGTH(array));
        sort_algorithm->function(array, ARRAY_LENGTH(array));
        print_array(array, ARRAY_LENGTH(array));
        assert(is_sorted(array, ARRAY_LENGTH(array)));
    }

    printf(" -> %.3f ms\n", 1000.0 * (clock() - start_time) / CLOCKS_PER_SEC);
}

void set_constant_values(int *array, int size)
{
    int i;

    for (i = 0; i < size; i++)
        array[i] = 10;
}

void set_ascending_values(int *array, int size)
{
    int i;

    for (i = 0; i < size; i++)
        array[i] = i + 10;
}

void set_descending_values(int *array, int size)
{
    int i;

    for (i = 0; i < size; i++)
        array[i] = size - i + 9;
}

void set_random_values(int *array, int size)
{
    int i;

    for (i = 0; i < size; i++)
        array[i] = rand() % MODULO_IN_RANDOM_VALUE;
}

void print_array(const int *array, int size)
{
#ifdef DEBUG
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
#endif
}

int is_sorted(const int *array, int size)
{
    int i;

    for (i = 0; i < size - 1; i++)
        if (array[i] > array[i + 1])
            return 0;

    return 1;
}

void quick_sort_2way_partition(int *array, int size)
{
    if (size <= 1)
        return;

    quick_sort_2way_partition_range(array, 0, size - 1);
}

void quick_sort_2way_partition_range(int *array, int lower, int upper)
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

    if (lower < decrement_index)
        quick_sort_2way_partition_range(array, lower, decrement_index);
    if (increment_index < upper)
        quick_sort_2way_partition_range(array, increment_index, upper);
}

void quick_sort_3way_partition(int *array, int size)
{
    if (size <= 1)
        return;

    quick_sort_3way_partition_range(array, 0, size - 1);
}

void quick_sort_3way_partition_range(int *array, int lower, int upper)
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

    if (lower < low)
        quick_sort_3way_partition_range(array, lower, low - 1);
    if (mid < upper)
        quick_sort_3way_partition_range(array, mid, upper);
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

int random_index(int lower, int upper)
{
    return rand() % (upper - lower + 1) + lower;
}

int random_select(const int *array, int lower, int upper)
{
    return array[random_index(lower, upper)];
}

