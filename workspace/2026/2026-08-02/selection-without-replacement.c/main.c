#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MIN 10
#define MAX 99

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

void initialize(void);
void demonstration(void);
void selection_without_replacement(int *array, int n, int min, int max);
void print_array(const int *array, int n);

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
    selection_without_replacement(array, ARRAY_LENGTH(array), MIN, MAX);
    print_array(array, ARRAY_LENGTH(array));
}

void selection_without_replacement(int *array, int n, int min, int max)
{
    int n_selected = 0;

    for (int value = min; value <= max && n_selected < n; value++)
    {
        const double numerator = n - n_selected;
        const double denominator = max - value + 1;
        const double r = rand() / (RAND_MAX + 1.0);

        if (r < numerator / denominator)
            array[n_selected++] = value;
    }
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

