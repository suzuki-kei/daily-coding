using Console = System.Console;
using Random = System.Random;
using static System.Linq.Enumerable;

class Application
{

    private static readonly Random random = new();

    static void Main()
    {
        int[] xs = GenerateRandomAscendingValues(20);
        Console.WriteLine("{0}", string.Join(" ", xs));

        int lower = xs[0] - 1;
        int upper = xs[^1] + 1;

        foreach (int target in Range(lower, upper))
        {
            int index = BinarySearch(xs, target);
            Console.WriteLine("target={0}, index={1}", target, index);
        }
    }

    private static int[] GenerateRandomAscendingValues(int n)
    {
        int x = 9;
        return Range(0, n).Select(_ => x += random.Next(1, 5)).ToArray();
    }

    private static int BinarySearch(in int[] xs, int target)
    {
        return BinarySearch(xs, target, 0, xs.Length - 1);
    }

    private static int BinarySearch(in int[] xs, int target, int lower, int upper)
    {
        if (lower > upper)
            return -1;

        int center = (lower + upper) / 2;

        if (target == xs[center])
            return center;

        if (target < xs[center])
            return BinarySearch(xs, target, lower, center - 1);
        else
            return BinarySearch(xs, target, center + 1, upper);
    }

}

