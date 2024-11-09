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

        System.Console.WriteLine("{0}:", description);
        System.Console.WriteLine("{0}", formatted);
    }

    private static int Factorial(int n)
    {
        return Factorial(n, 1);
    }

    private static int Factorial(int n, int accumulated)
    {
        if (n == 0)
            return accumulated;
        return Factorial(n - 1, accumulated * n);
    }

    private static int Fibonacci(int n)
    {
        return Fibonacci(n, 0, 1);
    }

    private static int Fibonacci(int n, int a, int b)
    {
        if (n == 0)
            return a;
        return Fibonacci(n - 1, b, a + b);
    }

    private static string FizzBuzz(int n)
    {
        if (n % 15 == 0)
            return "FizzBuzz";
        if (n % 5 == 0)
            return "Buzz";
        if (n % 3 == 0)
            return "Fizz";
        return n.ToString();
    }

}

