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
        HeapSort(values);
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

    private static void HeapSort(int[] values)
    {
        HeapBuild(values);
        HeapPopAll(values);
    }

    private static void HeapBuild(int[] values)
    {
        for (int i = values.Length / 2 - 1; 0 <= i; i--)
            HeapShiftDown(values, values.Length, i);
    }

    private static void HeapPopAll(int[] values)
    {
        for (int i = values.Length - 1; 1 <= i; i--)
        {
            Swap(ref values[i], ref values[0]);
            HeapShiftDown(values, i, 0);
        }
    }

    private static void HeapShiftDown(int[] values, int n, int i)
    {
        while (i * 2 + 1 < n)
        {
            int maximumIndex = i;
            int leftIndex = i * 2 + 1;
            int rightIndex = i * 2 + 2;

            if (leftIndex < n && values[leftIndex] > values[maximumIndex])
                maximumIndex = leftIndex;

            if (rightIndex < n && values[rightIndex] > values[maximumIndex])
                maximumIndex = rightIndex;

            if (i == maximumIndex)
                break;

            Swap(ref values[i], ref values[maximumIndex]);
            i = maximumIndex;
        }
    }

    private static void Swap<T>(ref T value1, ref T value2)
    {
        (value1, value2) = (value2, value1);
    }

}

