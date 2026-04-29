#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

typedef void (*fn_make_heap)(int *array, int n);

void initialize(void);
void demonstration(void);
void demonstration_step(const char *label, fn_make_heap make_heap);
void set_random_values(int *array, int n);
int random_range(int min, int max);
void print_array(const int *array, int n);
int is_heap(const int *array, int n);
int is_sorted(const int *array, int n);
void make_heap_shift_up(int *array, int n);
void shift_up(int *array, int n, int i);
void make_heap_shift_down(int *array, int n);
void shift_down(int *array, int n, int i);
void pop_all(int *array, int n);
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
    demonstration_step("shift_up", make_heap_shift_up);
    demonstration_step("shift_down", make_heap_shift_down);
}

void demonstration_step(const char *label, fn_make_heap make_heap)
{
    printf("==== %s\n", label);

    int array[20];
    set_random_values(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
    make_heap(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
    pop_all(array, ARRAY_LENGTH(array));
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

    printf(
        " (%s, %s)\n",
        is_heap(array, n) ? "heap" : "not heap",
        is_sorted(array, n) ? "sorted" : "not sorted");
}

int is_heap(const int *array, int n)
{
    for (int i = 1; i < n; i++)
        if (array[i] > array[(i - 1) / 2])
            return 0;

    return 1;
}

int is_sorted(const int *array, int n)
{
    for (int i = 0; i + 1 < n; i++)
        if (array[i] > array[i + 1])
            return 0;

    return 1;
}

void make_heap_shift_up(int *array, int n)
{
    for (int i = 1; i < n; i++)
        shift_up(array, n, i);
}

void shift_up(int *array, int n, int i)
{
    int child_index = i;
    int parent_index = (i - 1) / 2;

    while (child_index >= 1 && array[child_index] > array[parent_index])
    {
        swap(&array[child_index], &array[parent_index]);
        child_index = parent_index;
        parent_index = (child_index - 1) / 2;
    }
}

void make_heap_shift_down(int *array, int n)
{
    for (int i = (n - 1) / 2; i >= 0; i--)
        shift_down(array, n, i);
}

void shift_down(int *array, int n, int i)
{
    for (;;)
    {
        int maximum_index = i;
        int left_index = i * 2 + 1;
        int right_index = i * 2 + 2;

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

void pop_all(int *array, int n)
{
    for (int i = n - 1; i >= 1; i--)
    {
        swap(&array[0], &array[i]);
        shift_down(array, i, 0);
    }
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

