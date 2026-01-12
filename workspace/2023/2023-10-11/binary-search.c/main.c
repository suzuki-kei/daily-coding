#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 20

void initialize();
void demonstration();
void set_random_sorted_values(int *values, int size);
void print_values(const int *values, int size);
int binary_search(const int *values, int size, int target);
int _binary_search(const int *values, int lower, int upper, int target);

int main(void)
{
    initialize();
    demonstration();

    return 0;
}

void initialize()
{
    srand(time(NULL));
}

void demonstration()
{
    int target;
    int values[SIZE];

    set_random_sorted_values(values, SIZE);
    print_values(values, SIZE);

    for (target = values[0] - 1; target < values[SIZE - 1] + 1; target++)
        printf("target=%d, index=%d\n", target, binary_search(values, SIZE, target));
}

void set_random_sorted_values(int *values, int size)
{
    int i;
    int offset = 10;

    for (i = 0; i < size; i++)
        offset = values[i] = rand() % 5 + 1 + offset;
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
    int i = lower + upper;

    if (!(lower <= i && i <= upper))
        return -1;
    if (values[i] < target)
        return _binary_search(values, i + 1, upper, target);
    if (values[i] > target)
        return _binary_search(values, lower, i - 1, target);
    return i;
}

