using System;
using System.Collections.Generic;
using System.Linq;

class Application
{

    private static readonly Random random = new();

    static void Main()
    {
        int[] array = GenerateRandomValues(20, 10..100);
        PrintArray(array);
        ShellSort(array);
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

    private static void PrintArray(IReadOnlyList<int> array)
    {
        if (IsSorted(array))
            Console.WriteLine("{0} (sorted)", string.Join(" ", array));
        else
            Console.WriteLine("{0} (not sorted)", string.Join(" ", array));
    }

    private static bool IsSorted(IReadOnlyList<int> array)
    {
        for (int i = 0; i + 1 < array.Count; i++)
            if (array[i] > array[i + 1])
                return false;

        return true;
    }

    private static void ShellSort(int[] array)
    {
        for (int gap = ToInitialGap(array.Length); 1 <= gap; gap /= 3)
        {
            for (int end = gap; end < array.Length; end++)
            {
                int i = end;
                int value = array[end];

                while (gap <= i && value < array[i - gap])
                {
                    array[i] = array[i - gap];
                    i -= gap;
                }

                array[i] = value;
            }
        }
    }

    private static int ToInitialGap(int n)
    {
        int gap = 1;

        while (gap * 3 + 1 < n)
            gap = gap * 3 + 1;

        return gap;
    }

}

