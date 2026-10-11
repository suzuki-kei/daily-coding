using Console = System.Console;
using Enumerable = System.Linq.Enumerable;
using Random = System.Random;
using Range = System.Range;
using static System.Linq.Enumerable;

class Application
{

    private static readonly Random random = new();

    static void Main()
    {
        int[] array = GenerateRandomValues(20, 10..100);
        PrintArray(array);
        CombSort(array);
        PrintArray(array);
    }

    private static int[] GenerateRandomValues(int n, Range range)
    {
        return Enumerable.Range(0, n).Select(_ => RandomRange(range)).ToArray();
    }

    private static int RandomRange(Range range)
    {
        return random.Next(range.Start.Value, range.End.Value);
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
        for (int i = 0; i + 1 < array.Length; i++)
            if (array[i] > array[i + 1])
                return false;

        return true;
    }

    private static void CombSort(int[] array)
    {
        int gap = array.Length;
        bool swapped = false;

        do
        {
            gap = ToNextGap(gap);
            swapped = false;

            for (int i = 0; i + gap < array.Length; i++)
            {
                if (array[i] > array[i + gap])
                {
                    Swap(ref array[i], ref array[i + gap]);
                    swapped = true;
                }
            }
        }
        while (1 < gap || swapped);
    }

    private static int ToNextGap(int gap)
    {
        if (gap <= 2)
            return 1;

        if (13 <= gap && gap <= 15)
            return 11;

        return gap * 10 / 13;
    }

    private static void Swap<T>(ref T value1, ref T value2)
    {
        (value1, value2) = (value2, value1);
    }

}

