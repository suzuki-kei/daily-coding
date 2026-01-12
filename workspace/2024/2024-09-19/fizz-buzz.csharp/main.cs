using System;

class App
{

    static void Main()
    {
        for (int i = 1; i <= 100; i++)
        {
            System.Console.WriteLine(FizzBuzz(i));
        }
    }

    private static string FizzBuzz(int n)
    {
        return (n % 5, n % 3) switch {
            (0, 0) => "FizzBuzz",
            (0, _) => "Buzz",
            (_, 0) => "Fizz",
            (_, _) => n.ToString(),
        };
    }

}

