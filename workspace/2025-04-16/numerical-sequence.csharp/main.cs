using System.Linq;
using System.Collections.Generic;

class Application
{

    static void Main()
    {
        PrintSequence("factorials", Factorial, 1, 10);
        PrintSequence("fibonacci numbers", Fibonacci, 0, 20);
        PrintSequence("fizz buzz values", FizzBuzz, 1, 100);
    }

    private delegate T F<T>(int n);

    private static void PrintSequence<T>(string description, F<T> f, int min, int max)
    {
        IEnumerable<T> values = Enumerable.Range(min, max).Select(n => f(n));
        string formatted = string.Join(" ", values);

        System.Console.WriteLine($"{description}:");
        System.Console.WriteLine($"{formatted}");
    }

    private static int Factorial(int n)
    {
        return Factorial(n, 1);
    }

    private static int Factorial(int n, int fm)
    {
        return n switch
        {
            0 => fm,
            _ => Factorial(n - 1, fm * n),
        };
    }

    private static int Fibonacci(int n)
    {
        return Fibonacci(n, 0, 1);
    }

    private static int Fibonacci(int n, int a, int b)
    {
        return n switch
        {
            0 => a,
            _ => Fibonacci(n - 1, b, a + b),
        };
    }

    private static string FizzBuzz(int n)
    {
        return (n % 5, n % 3) switch
        {
            (0, 0) => "FizzBuzz",
            (0, _) => "Buzz",
            (_, 0) => "Fizz",
            (_, _) => n.ToString(),
        };
    }

}

