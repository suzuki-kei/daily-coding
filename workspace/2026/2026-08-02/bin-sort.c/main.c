#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MIN 10
#define MAX 99

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

void initialize(void);
void demonstration(void);
void set_random_values(int *array, int n, int min, int max);
void selection_without_replacement(int *array, int n, int min, int max);
void shuffle(int *array, int n);
int random_range(int min, int max);
void swap(int *value1, int *value2);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
void bin_sort(int *array, int n, int min, int max);

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
    set_random_values(array, ARRAY_LENGTH(array), MIN, MAX);
    print_array(array, ARRAY_LENGTH(array));
    bin_sort(array, ARRAY_LENGTH(array), MIN, MAX);
    print_array(array, ARRAY_LENGTH(array));
}

void set_random_values(int *array, int n, int min, int max)
{
    selection_without_replacement(array, n, min, max);
    shuffle(array, n);
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

void shuffle(int *array, int n)
{
    for (int i = 0; i < n - 1; i++)
    {
        const int target = random_range(i, n - 1);
        swap(&array[i], &array[target]);
    }
}

int random_range(int min, int max)
{
    return rand() % (max - min + 1) + min;
}

void swap(int *value1, int *value2)
{
    const int temporary = *value1;
    *value1 = *value2;
    *value2 = temporary;
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

void bin_sort(int *array, int n, int min, int max)
{
    unsigned char *bit_array = NULL;
    const int n_bit_array = ((max - min + 1) + (CHAR_BIT - 1)) / CHAR_BIT;

    if ((bit_array = calloc(n_bit_array, sizeof(unsigned char))) == NULL)
    {
        fprintf(stderr, "allocation failed.\n");
        exit(1);
    }

    for (int i = 0; i < n; i++)
    {
        const int i_bit_array = (array[i] - min) / CHAR_BIT;
        const int bit_offset = (array[i] - min) % CHAR_BIT;

        bit_array[i_bit_array] |= 1 << bit_offset;
    }

    int i_array = 0;

    for (int value = min; value <= max; value++)
    {
        const int i_bit_array = (value - min) / CHAR_BIT;
        const int bit_offset = (value - min) % CHAR_BIT;

        if (bit_array[i_bit_array] & (1 << bit_offset))
            array[i_array++] = value;
    }

    free(bit_array);
}

