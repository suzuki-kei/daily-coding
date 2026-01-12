#include <stdio.h>

void print_sequence(const char *description, int (*f)(int), int min, int max);
int factorial(int n);
int fibonacci(int n);

int main(void)
{
    print_sequence("factorials", factorial, 1, 10);
    print_sequence("fibonacci numbers", fibonacci, 0, 20);

    return 0;
}

void print_sequence(const char *description, int (*f)(int), int min, int max)
{
    int n;
    const char *delimiter = "";

    printf("%s:\n", description);

    for (n = min; n <= max; n++)
    {
        printf("%s%d", delimiter, f(n));
        delimiter = " ";
    }

    printf("\n");
}

int factorial(int n)
{
    if (n == 0)
        return 1;
    return n * factorial(n - 1);
}

int fibonacci(int n)
{
    if (n == 0)
        return 0;
    if (n == 1)
        return 1;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

