using System.Collections.Generic;
using System.Linq;
using System;

class Application
{

    private static Random random = new();

    static void Main()
    {
        int[] values = GenerateRandomValues(20, 10..100);
        PrintValues(values);
        SelectionSort(values);
        PrintValues(values);
    }

    private static int[] GenerateRandomValues(int n, Range range)
    {
        return Enumerable.Range(0, n).Select(_ => RandomRange(range)).ToArray();
    }

    private static int RandomRange(Range range)
    {
        return random.Next(range.Start.Value, range.End.Value);
    }

    private static void PrintValues(IReadOnlyList<int> values)
    {
        if (IsSorted(values))
            Console.WriteLine("{0} (sorted)", string.Join(" ", values));
        else
            Console.WriteLine("{0} (not sorted)", string.Join(" ", values));
    }

    private static bool IsSorted(IReadOnlyList<int> values)
    {
        return Enumerable.Range(0, values.Count - 1).All(i => values[i] <= values[i + 1]);
    }

    private static void SelectionSort(int[] values)
    {
        for (int begin = 0; begin + 1 < values.Length; begin++)
        {
            int minimumIndex = begin;

            for (int i = begin + 1; i < values.Length; i++)
                if (values[i] < values[minimumIndex])
                    minimumIndex = i;

            Swap(ref values[begin], ref values[minimumIndex]);
        }
    }

    private static void Swap<T>(ref T value1, ref T value2)
    {
        (value1, value2) = (value2, value1);
    }

}

