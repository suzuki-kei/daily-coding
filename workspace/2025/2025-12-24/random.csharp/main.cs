using Console = System.Console;
using Random = System.Random;
using static System.Linq.Enumerable;

class Application
{

    private static readonly Random random = new();

    static void Main()
    {
        int[] values = GenerateRandomValues(20);
        Console.WriteLine("{0}", string.Join(" ", values));
    }

    private static int[] GenerateRandomValues(int n)
    {
        return Range(0, n).Select(_ => random.Next(10, 99)).ToArray();
    }

}

