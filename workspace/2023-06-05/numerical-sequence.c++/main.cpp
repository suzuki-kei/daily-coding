#include <iostream>
#include <string>

template<typename T>
void print_sequence(const char *description, T (*f)(int), int min, int max);
int factorial(int n);
int fibonacci(int n);
std::string fizz_buzz(int n);

int main()
{
    print_sequence("factorials", factorial, 1, 10);
    print_sequence("fibonacci numbers", fibonacci, 0, 20);
    print_sequence("fizz buzz values", fizz_buzz, 1, 100);

    return 0;
}

template<typename T>
void print_sequence(const char *description, T (*f)(int), int min, int max)
{
    std::cout << description << ":" << std::endl;

    const char *delimiter = "";

    for (int i = min; i <= max; i++)
    {
        std::cout << delimiter << f(i);
        delimiter = " ";
    }

    std::cout << std::endl;
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

std::string fizz_buzz(int n)
{
    if (n % 15 == 0)
        return std::string("FizzBuzz");
    if (n % 5 == 0)
        return std::string("Buzz");
    if (n % 3 == 0)
        return std::string("Fizz");
    return std::to_string(n);
}

