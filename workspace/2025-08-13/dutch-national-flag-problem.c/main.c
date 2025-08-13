#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

void initialize(void);
void demonstration(void);
void set_random_values(int *array, int size);
void print_array(const int *array, int size);
void partition(int *array, int size);
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
    int array[10];

    set_random_values(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
    partition(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int size)
{
    int i;

    for (i = 0; i < size; i++)
        array[i] = rand() % 10;
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

    printf("\n");
}

void partition(int *array, int size)
{
    int low = 0;
    int mid = 0;
    int high = size - 1;
    const int pivot = random_select(array, 0, size - 1);

    while (mid <= high)
    {
        if (array[mid] < pivot)
            swap(&array[low++], &array[mid++]);
        else if (array[mid] > pivot)
            swap(&array[mid], &array[high--]);
        else
            mid++;

        printf("pivot = %d, low = %d, mid = %d, high = %d\n", pivot, low, mid, high);
        print_array(array, size);
    }

    printf("pivot = %d, low = %d, mid = %d, high = %d\n", pivot, low, mid, high);
    print_array(array, size);
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

