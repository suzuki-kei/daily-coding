#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

void initialize(void);
void demonstration(void);
char **make_random_strings(int n);
char *make_random_string();
char random_char();
void free_strings(char ***strings, int n);
void print_strings(char **strings, int n);
int is_sorted(char **strings, int n);
void american_flag_sort(char **strings, int n);
void american_flag_sort_steps(char **strings, int n, int radix, int *lengths, char **temporary_strings);

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
    int n = 20;
    char **strings = NULL;

    if ((strings = make_random_strings(n)) == NULL)
        goto CLEANUP;

    print_strings(strings, n);
    american_flag_sort(strings, n);
    print_strings(strings, n);

CLEANUP:
    free_strings(&strings, n);
}

char **make_random_strings(int n)
{
    int i = 0;
    char **strings = NULL;

    if ((strings = malloc(sizeof(char *) * n)) == NULL)
        goto FAILED;

    for (i = 0; i < n; i++)
        strings[i] = NULL;

    for (i = 0; i < n; i++)
        if ((strings[i] = make_random_string()) == NULL)
            goto FAILED;

    return strings;

FAILED:
    free_strings(&strings, n);
    return NULL;
}

char *make_random_string()
{
    int i = 0;
    int n = rand() % 2 + 3;
    char *string = NULL;

    if ((string = malloc(sizeof(char) * n)) == NULL)
        goto FAILED;

    for (i = 0; i < n; i++)
        string[i] = '\0';

    for (i = 0; i < n - 1; i++)
        string[i] = random_char();

    return string;

FAILED:
    free(string);
    return NULL;
}

char random_char()
{
    return rand() % ('z' - 'a' + 1) + 'a';
}

void free_strings(char ***strings, int n)
{
    int i = 0;

    if (*strings == NULL)
        return;

    for (i = 0; i < n; i++)
    {
        free((*strings)[i]);
        (*strings)[i] = NULL;
    }

    *strings = NULL;
}

void print_strings(char **strings, int n)
{
    int i = 0;
    const char *separator = "";

    for (i = 0; i < n; i++)
    {
        printf("%s%s", separator, strings[i]);
        separator = " ";
    }

    if (is_sorted(strings, n))
        printf(" (sorted) \n");
    else
        printf(" (not sorted) \n");
}

int is_sorted(char **strings, int n)
{
    int i = 0;

    for (i = 0; i < n - 1; i++)
        if (strcmp(strings[i], strings[i + 1]) > 0)
            return 0;

    return 1;
}

#define RADIX 256

void american_flag_sort(char **strings, int n)
{
    int *lengths = NULL;
    char **temporary_strings = NULL;

    if ((lengths = malloc(sizeof(int) * n)) == NULL)
        goto FAILED;

    if ((temporary_strings = malloc(sizeof(char *) * n)) == NULL)
        goto FAILED;

    american_flag_sort_steps(strings, n, 0, lengths, temporary_strings);

    free(lengths);
    free(temporary_strings);
    return;

FAILED:
    free(lengths);
    free(temporary_strings);
    fprintf(stderr, "memory allocation failed.");
    exit(1);
}

void american_flag_sort_steps(char **strings, int n, int radix, int *lengths, char **temporary_strings)
{
    int i = 0;
    int counts[RADIX] = {};
    int offsets[RADIX] = {};

    if (n <= 1)
        return;

    for (i = 0; i < n; i++)
        lengths[i] = -1;

    for (i = 0; i < n; i++)
        if (lengths[i] == i)
            counts[i] = 0;
        else if (strings[i][radix] == '\0')
            lengths[i] = i, counts[i] = 0;
        else
            counts[(unsigned int) strings[i][radix]]++;

    for (i = 1; i < RADIX; i++)
        offsets[i] = offsets[i - 1] + counts[i - 1];

    for (i = 0; i < n; i++)
    {
        int offsets_index = lengths[i] < radix ? strings[i][radix] : 0;
        temporary_strings[offsets[offsets_index]++] = strings[i];
    }

    for (i = 0; i < n; i++)
        strings[i] = temporary_strings[i];

    for (i = 0; i < RADIX; i++)
    {
        char **substrings = &strings[offsets[i] - counts[i]];
        int substrings_length = counts[i];
        american_flag_sort_steps(substrings, substrings_length, radix + 1, lengths, temporary_strings);
    }
}

