#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 20

void initialize(void);
void demonstration(void);
void set_random_ascending_values(int *values, int size);
void print_values(const int *values, int size);
int binary_search(const int *values, int size, int target);
int _binary_search(const int *values, int lower, int upper, int target);

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
    int values[SIZE];
    int lower, upper, target, index;

    set_random_ascending_values(values, SIZE);
    print_values(values, SIZE);

    lower = values[0] - 1;
    upper = values[SIZE - 1] + 1;

    for (target = lower; target <= upper; target++)
    {
        index = binary_search(values, SIZE, target);
        printf("target=%d, index=%d\n", target, index);
    }
}

void set_random_ascending_values(int *values, int size)
{
    int i;
    int offset = 10;

    for (i = 0; i < size; i++)
    {
        values[i] = rand() % 5 + offset;
        offset = values[i] + 1;
    }
}

void print_values(const int *values, int size)
{
    int i;
    const char *delimiter = "";

    for (i = 0; i < size; i++)
    {
        printf("%s%d", delimiter, values[i]);
        delimiter = " ";
    }
    printf("\n");
}

int binary_search(const int *values, int size, int target)
{
    return _binary_search(values, 0, size - 1, target);
}

int _binary_search(const int *values, int lower, int upper, int target)
{
    const int center = (lower + upper) / 2;

    if (center < lower || upper < center)
        return -1;
    if (target < values[center])
        return _binary_search(values, lower, center - 1, target);
    if (target > values[center])
        return _binary_search(values, center + 1, upper, target);
    return center;
}

