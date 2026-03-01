#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

void initialize(void);
void demonstration(void);
void set_random_values(int *array, int n);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void heap_sort(int *array, int n);
int is_heap(const int *array, int n);
void heap_push(int *array, int n, int value);
int heap_pop(int *array, int n);
int get_greater_child_index(const int *array, int n, int parent);

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

    set_random_values(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
    heap_sort(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int n)
{
    for (int i = 0; i < n; i++)
        array[i] = rand() % 90 + 10;
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
    for (int i = 0; i < n - 1; i++)
        if (array[i] > array[i + 1])
            return 0;

    return 1;
}

void heap_sort(int *array, int n)
{
    for (int i = 1; i < n; i++)
        heap_push(array, i, array[i]);

    for (int i = 0; i < n; i++)
        array[n - i - 1] = heap_pop(array, n - i);
}

int is_heap(const int *array, int n)
{
    for (int i = 1; i < n; i++)
        if (array[i] > array[(i - 1) / 2])
            return 0;

    return 1;
}

void heap_push(int *array, int n, int value)
{
    int i = n;

    while (i > 0 && value > array[(i - 1) / 2])
    {
        array[i] = array[(i - 1) / 2];
        i = (i - 1) / 2;
    }

    array[i] = value;
}

int heap_pop(int *array, int n)
{
    const int max_value = array[0];
    const int min_value = array[n - 1];
    array[0] = array[n - 1];

    int i = 0;
    int child = get_greater_child_index(array, n - 1, 0);

    while (child != -1 && min_value < array[child])
    {
        array[i] = array[child];
        i = child;
        child = get_greater_child_index(array, n - 1, i);
    }

    array[i] = min_value;

    return max_value;
}

int get_greater_child_index(const int *array, int n, int i)
{
    const int left = i * 2 + 1;
    const int right = i * 2 + 2;

    if (right < n && array[left] < array[right])
        return right;

    if (left < n)
        return left;

    return -1;
}

