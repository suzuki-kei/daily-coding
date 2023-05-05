#include <iostream>
#include <string>

int factorial(int n);
int fibonacci(int n);
std::string fizzbuzz(int n);

template <typename T>
void show_numerical_sequence(const char *description, T (*f)(int), int lower, int upper)
{
    std::cout << description << ":" << std::endl;

    const char *delimiter = "";

    for (int n = lower; n <= upper; n++)
    {
        std::cout << delimiter << f(n);
        delimiter = " ";
    }
    std::cout << std::endl;
}

int main(void)
{
    show_numerical_sequence("factorials", factorial, 1, 10);
    show_numerical_sequence("fibonacci numbers", fibonacci, 0, 20);
    show_numerical_sequence("FizzBuzz values", fizzbuzz, 1, 100);
}

int factorial(int n)
{
    if (n == 0)
        return 1;
    return n * factorial(n - 1);
}

int fibonacci(int n)
{
    if (n == 0 || n == 1)
        return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

std::string fizzbuzz(int n)
{
    if (n % 15 == 0)
        return std::string("FizzBuzz");
    else if (n % 5 == 0)
        return std::string("Buzz");
    else if (n % 3 == 0)
        return std::string("Fizz");
    else
        return std::to_string(n);
}

