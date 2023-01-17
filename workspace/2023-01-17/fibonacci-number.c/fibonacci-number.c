#include <stdio.h>

void fibonacci(int n);

int main(void)
{
    fibonacci(20);

    return 0;
}

void fibonacci(int n)
{
    int i;
    int a = 0;
    int b = 1;

    for (i = 0; i <= n; i++)
    {
        printf("%d\n", a);
        b = a + b;
        a = b - a;
    }
}

