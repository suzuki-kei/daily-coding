using System.Collections.Generic;
using System.Linq;
using System;

class Application
{

    private static Random random = new();

    static void Main()
    {
        Range range = 0..10;
        int[] values = GenerateRandomValues(20, range);
        PrintValues(values);
        DistributionCountingSort(values, range);
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

    private static void DistributionCountingSort(int[] values, Range range)
    {
        int[] buffer = new int[values.Length];
        int[] counts = new int[range.End.Value - range.Start.Value];

        for (int i = 0; i < values.Length; i++)
            counts[values[i] - range.Start.Value]++;

        for (int i = 1; i < counts.Length; i++)
            counts[i] += counts[i - 1];

        for (int i = values.Length - 1; 0 <= i; i--)
            buffer[--counts[values[i] - range.Start.Value]] = values[i];

        for (int i = 0; i < values.Length; i++)
            values[i] = buffer[i];
    }

    private static void Swap<T>(ref T value1, ref T value2)
    {
        (value1, value2) = (value2, value1);
    }

}

