using Console = System.Console;
using Random = System.Random;
using static System.Linq.Enumerable;

class Application
{
    static void Main()
    {
        int[] array = GenerateRandomValues(20);
        PrintArray(array);
        CombSort(array);
        PrintArray(array);
    }

    private static readonly Random random = new();

    private static int[] GenerateRandomValues(int n)
    {
        return Range(0, n).Select(_ => random.Next(10, 100)).ToArray();
    }

    private static void PrintArray(in int[] array)
    {
        if (IsSorted(array))
            Console.WriteLine("{0} (sorted)", string.Join(" ", array));
        else
            Console.WriteLine("{0} (not sorted)", string.Join(" ", array));
    }

    private static bool IsSorted(in int[] array)
    {
        for (int i = 0; i < array.Length - 1; i++)
            if (array[i] > array[i + 1])
                return false;

        return true;
    }

    private static void CombSort(int[] array)
    {
        int gap = array.Length;
        bool done = false;

        while (gap > 1 || !done)
        {
            gap = ComputeNextGap(gap);
            done = true;

            for (int i = 0; i + gap < array.Length; i += gap)
            {
                if (array[i] > array[i + gap])
                {
                    Swap(array, i, i + gap);
                    done = false;
                }
            }
        }
    }

    private static int ComputeNextGap(int gap)
    {
        if (gap <= 2)
            return 1;

        if (gap == 9 || gap == 10)
            return 11;

        return gap * 10 / 13;
    }

    private static void Swap(int[] array, int index1, int index2)
    {
        (array[index1], array[index2]) = (array[index2], array[index1]);
    }
}

