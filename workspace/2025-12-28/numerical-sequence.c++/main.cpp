#include <iostream>
#include <string>

template <typename T>
void print_sequence(const char *label, T (*f)(int n), int min, int max);
int factorial(int n);
int factorial(int n, int fm);
int fibonacci(int n);
int fibonacci(int n, int a, int b);
std::string fizz_buzz(int n);

int main()
{
    print_sequence("factorials", factorial, 1, 10);
    print_sequence("fibonacci numbers", fibonacci, 0, 20);
    print_sequence("fizz buzz values", fizz_buzz, 1, 100);

    return 0;
}

template
<
    typename T
>
void print_sequence(const char *label, T (*f)(int n), int min, int max)
{
    std::cout << label << ":" << std::endl;

    const char *separator = "";

    for (int n = min; n <= max; n++)
    {
        std::cout << separator << f(n);
        separator = " ";
    }

    std::cout << std::endl;
}

int factorial(int n)
{
    return factorial(n, 1);
}

int factorial(int n, int fm)
{
    if (n == 0)
        return fm;
    else
        return factorial(n - 1, fm * n);
}

int fibonacci(int n)
{
    return fibonacci(n, 0, 1);
}

int fibonacci(int n, int a, int b)
{
    if (n == 0)
        return a;
    else
        return fibonacci(n - 1, b, a + b);
}

std::string fizz_buzz(int n)
{
    if (n % 15 == 0)
        return "FizzBuzz";
    if (n % 5 == 0)
        return "Buzz";
    if (n % 3 == 0)
        return "Fizz";
    return std::to_string(n);
}

