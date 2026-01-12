#include <iostream>

int factorial(int n);
int fibonacci(int n);

template
<
    typename T,
    typename U
>
void show_numerical_sequence(
    const char *description, U (*f)(T), int lower, int upper)
{
    std::cout << description << ":" << std::endl;

    for (int n = lower; n <= upper; n++)
        std::cout << f(n) << " ";
    std::cout << std::endl;
}

int main(void)
{
    show_numerical_sequence("factorials", factorial, 1, 10);
    show_numerical_sequence("fibonacci numbers", fibonacci, 0, 20);
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

