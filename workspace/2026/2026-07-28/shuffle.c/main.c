#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

void initialize(void);
void demonstration(void);
void initialize_array(int *array, int n);
void print_array(const int *array, int n);
void shuffle(int *array, int n);
int random_range(int min, int max);
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
    initialize_array(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
    shuffle(array, ARRAY_LENGTH(array));
    print_array(array, ARRAY_LENGTH(array));
}

void initialize_array(int *array, int n)
{
    for (int i = 0; i < n; i++)
        array[i] = i + 10;
}

void print_array(const int *array, int n)
{
    const char *separator = "";

    for (int i = 0; i < n; i++)
    {
        printf("%s%d", separator, array[i]);
        separator = " ";
    }

    printf("\n");
}

void shuffle(int *array, int n)
{
    for (int i = 0; i < n; i++)
    {
        const int target = random_range(i, n - 1);
        swap(&array[i], &array[target]);
    }
}

int random_range(int min, int max)
{
    assert(min <= max);
    return rand() % (max - min + 1) + min;
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
}

