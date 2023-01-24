#include <stdio.h>

void fizz_buzz(int n);
void fizz_buzz_value(int n);

int main(void)
{
    fizz_buzz(100);

    return 0;
}

void fizz_buzz(int n)
{
    int i;

    for (i = 1; i <= n; i++)
        fizz_buzz_value(i);
}

void fizz_buzz_value(int n)
{
    if (n % 15 == 0)
        printf("FizzBuzz\n");
    else if (n % 5 == 0)
        printf("Buzz\n");
    else if (n % 3 == 0)
        printf("Fizz\n");
    else
        printf("%d\n", n);
}

