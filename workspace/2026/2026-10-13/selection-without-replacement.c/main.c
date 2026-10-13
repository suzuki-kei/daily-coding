#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void initialize(void);
void demonstration(int n, int begin, int end);
int selection_without_replacement(int *array, int n, int begin, int end);
void print_array(const int *array, int n);
double uniform();
int is_sorted(const int *array, int n);

int main(void)
{
    initialize();
    demonstration(20, 0, 10);
    demonstration(20, 10, 100);
    return 0;
}

void initialize(void)
{
    srand(time(NULL));
}

void demonstration(int n, int begin, int end)
{
    int array[n];
    int n_selected = selection_without_replacement(array, n, begin, end);
    print_array(array, n_selected);
}

int selection_without_replacement(int *array, int n, int begin, int end)
{
    int n_selected = 0;

    for (int value = begin; value < end; value++)
    {
        const int n_remaining = n - n_selected;
        const int n_candidates_remaining = end - value;
        const double selection_probability = n_remaining / (double) n_candidates_remaining;

        if (uniform() < selection_probability)
            array[n_selected++] = value;
    }

    return n_selected;
}

double uniform()
{
    return rand() / (RAND_MAX + 1.0);
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

