using System.Collections.Generic;
using System.Linq;
using System;

class Application
{

    delegate Range Partition(int[] array, Range range);

    private static Random random = new();

    static void Main()
    {
        int[] values = GenerateRandomValues(20, 10..100);
        PrintValues(values);
        CombSort(values);
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

    private static void CombSort(int[] values)
    {
        int gap = values.Length;
        bool swapped = false;

        do
        {
            gap = ToNextGap(gap);
            swapped = false;

            for (int i = 0; i + gap < values.Length; i++)
            {
                if (values[i] > values[i + gap])
                {
                    Swap(ref values[i], ref values[i + gap]);
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

