#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N_ARRAY 20
#define MIN 10
#define MAX 99
#define N_BUCKETS 10
#define VALUE_TYPE int

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

#define PRECONDITION(condition) \
    if (!(condition))                                               \
    {                                                               \
        fprintf(stderr, "pre-condition violation: %s", #condition); \
        exit(1);                                                    \
    }

typedef struct
{
    VALUE_TYPE *memory;
    int size;
    int capacity;
}
Bucket;

typedef struct
{
    Bucket **buckets;
    int n_buckets;
    int min;
    int max;
}
Buckets;

void initialize(void);
void demonstration(void);
int max(int value1, int value2);
void initialize_array(int *array, int n, int min, int max);
int random_range(int min, int max);
void print_array(const int *array, int n);
int is_sorted(const int *array, int n);
Buckets *new_buckets(int n_buckets, int min, int max, int initial_capacity);
void free_buckets(Buckets *buckets);
int add_to_buckets(Buckets *buckets, int value);
int reserve_bucket(Bucket *bucket, int minimum_capacity);
void bucket_sort(int *array, int n, int min, int max, int n_buckets, int initial_capacity);
void sort_bucket_values(Bucket *bucket);
void insertion_sort(int *array, int n);
void insert(int *array, int i);

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
    int array[N_ARRAY];
    int initial_capacity = max(1, ARRAY_LENGTH(array) / N_BUCKETS);
    initialize_array(array, ARRAY_LENGTH(array), MIN, MAX);
    print_array(array, ARRAY_LENGTH(array));
    bucket_sort(array, ARRAY_LENGTH(array), MIN, MAX, N_BUCKETS, initial_capacity);
    print_array(array, ARRAY_LENGTH(array));
}

int max(int value1, int value2)
{
    if (value1 >= value2)
        return value1;
    else
        return value2;
}

void initialize_array(int *array, int n, int min, int max)
{
    PRECONDITION(array != NULL);
    PRECONDITION(n >= 0);
    PRECONDITION(min <= max);

    for (int i = 0; i < n; i++)
        array[i] = random_range(min, max);
}

int random_range(int min, int max)
{
    PRECONDITION(min <= max);

    return rand() % (max - min + 1) + min;
}

void print_array(const int *array, int n)
{
    PRECONDITION(array != NULL);
    PRECONDITION(n >= 0);

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
    PRECONDITION(array != NULL);
    PRECONDITION(n >= 0);

    for (int i = 0; i + 1 < n; i++)
        if (array[i] > array[i + 1])
            return 0;

    return 1;
}

Buckets *new_buckets(int n_buckets, int min, int max, int initial_capacity)
{
    PRECONDITION(n_buckets >= 1);
    PRECONDITION(min <= max);
    PRECONDITION(initial_capacity >= 0);

    Buckets *buckets = NULL;

    if ((buckets = malloc(sizeof(Buckets))) == NULL)
        goto FAILED;

    buckets->buckets   = NULL;
    buckets->n_buckets = n_buckets;
    buckets->min       = min;
    buckets->max       = max;

    if ((buckets->buckets = malloc(n_buckets * sizeof(Bucket *))) == NULL)
        goto FAILED;

    for (int i = 0; i < n_buckets; i++)
        buckets->buckets[i] = NULL;

    for (int i = 0; i < n_buckets; i++)
    {
        Bucket *bucket = malloc(sizeof(Bucket));

        if (bucket == NULL)
            goto FAILED;

        *bucket = (Bucket) {NULL, 0, 0};
        buckets->buckets[i] = bucket;
    }

    for (int i = 0; i < n_buckets; i++)
        if (!reserve_bucket(buckets->buckets[i], initial_capacity))
            goto FAILED;

    return buckets;

FAILED:
    free_buckets(buckets);
    return NULL;
}

void free_buckets(Buckets *buckets)
{
    if (buckets != NULL)
    {
        if (buckets->buckets != NULL)
        {
            for (int i = 0; i < buckets->n_buckets; i++)
            {
                if (buckets->buckets[i] != NULL)
                {
                    free(buckets->buckets[i]->memory);
                    free(buckets->buckets[i]);
                }
            }

            free(buckets->buckets);
        }

        free(buckets);
    }
}

int add_to_buckets(Buckets *buckets, int value)
{
    PRECONDITION(buckets != NULL);
    PRECONDITION(buckets->min <= value && value <= buckets->max);

    const int numerator = (value - buckets->min) * buckets->n_buckets;
    const int denominator = buckets->max - buckets->min + 1;
    const int i_buckets = numerator / denominator;

    Bucket *bucket = buckets->buckets[i_buckets];

    if (!reserve_bucket(bucket, bucket->size + 1))
        return 0;

    bucket->memory[bucket->size++] = value;
    return 1;
}

int reserve_bucket(Bucket *bucket, int minimum_capacity)
{
    PRECONDITION(bucket != NULL);
    PRECONDITION(minimum_capacity >= 0);

    if (minimum_capacity == 0)
        return 1;

    if (bucket->capacity >= minimum_capacity)
        return 1;

    int *memory = realloc(bucket->memory, minimum_capacity * sizeof(int));

    if (memory == NULL)
        return 0;

    bucket->memory   = memory;
    bucket->capacity = minimum_capacity;
    return 1;
}

void bucket_sort(int *array, int n, int min, int max, int n_buckets, int initial_capacity)
{
    PRECONDITION(array != NULL);
    PRECONDITION(n >= 0);
    PRECONDITION(min <= max);
    PRECONDITION(n_buckets >= 1);
    PRECONDITION(initial_capacity >= 0);

    Buckets *buckets = new_buckets(n_buckets, min, max, initial_capacity);

    if (buckets == NULL)
        goto FAILED;

    for (int i = 0; i < n; i++)
        if (!add_to_buckets(buckets, array[i]))
            goto FAILED;

    for (int i_buckets = 0; i_buckets < n_buckets; i_buckets++)
        sort_bucket_values(buckets->buckets[i_buckets]);

    int i_array = 0;

    for (int i_buckets = 0; i_buckets < n_buckets; i_buckets++)
    {
        const Bucket *bucket = buckets->buckets[i_buckets];

        for (int i = 0; i < bucket->size; i++)
            array[i_array++] = bucket->memory[i];
    }

    free_buckets(buckets);
    return;

FAILED:
    free_buckets(buckets);
    fprintf(stderr, "allocation failed.\n");
    exit(1);
}

void sort_bucket_values(Bucket *bucket)
{
    PRECONDITION(bucket != NULL);
    PRECONDITION(bucket->memory != NULL);
    PRECONDITION(bucket->size >= 0);

    insertion_sort(bucket->memory, bucket->size);
}

void insertion_sort(int *array, int n)
{
    PRECONDITION(array != NULL);
    PRECONDITION(n >= 0);

    for (int i = 1; i < n; i++)
        insert(array, i);
}

void insert(int *array, int i)
{
    PRECONDITION(array != NULL);
    PRECONDITION(i >= 0);

    const int value = array[i];

    while (i >= 1 && value < array[i - 1])
    {
        array[i] = array[i - 1];
        i--;
    }

    array[i] = value;
}

