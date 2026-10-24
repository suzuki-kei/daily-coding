using System.Collections.Generic;
using System.Linq;
using System;

class Application
{

    delegate Range Partition(int[] array, Range range);

    private static Random random = new();

    static void Main()
    {
        Demonstration("partition 2-way", Partition2Way);
        Demonstration("partition 3-way", Partition3Way);
    }

    private static void Demonstration(string label, Partition partition)
    {
        Console.WriteLine("==== {0}", label);
        int[] values = GenerateRandomValues(20, 10..100);
        PrintValues(values);
        QuickSort(values, partition);
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

    private static void QuickSort(int[] values, Partition partition)
    {
        QuickSort(values, partition, 0 .. values.Length);
    }

    private static void QuickSort(int[] values, Partition partition, Range range)
    {
        while (range.Start.Value < range.End.Value - 1)
        {
            Range middle = partition(values, range);
            int nLeft = middle.Start.Value - range.Start.Value;
            int nRight = range.End.Value - range.End.Value;

            if (nLeft < nRight)
            {
                QuickSort(values, partition, range.Start.Value .. middle.Start.Value);
                range = middle.End.Value .. range.End.Value;
            }
            else
            {
                QuickSort(values, partition, middle.End.Value .. range.End.Value);
                range = range.Start.Value .. middle.Start.Value;
            }
        }
    }

    private static Range Partition2Way(int[] values, Range range)
    {
        int incrementIndex = range.Start.Value;
        int decrementIndex = range.End.Value - 1;
        int pivot = values[RandomRange(range)];

        while (incrementIndex <= decrementIndex)
        {
            while (values[incrementIndex] < pivot)
                incrementIndex++;

            while (values[decrementIndex] > pivot)
                decrementIndex--;

            if (incrementIndex <= decrementIndex)
                Swap(ref values[incrementIndex++], ref values[decrementIndex--]);
        }

        int middleBegin = decrementIndex + 1;
        int middleEnd = incrementIndex;
        return middleBegin..middleEnd;
    }

    private static Range Partition3Way(int[] values, Range range)
    {
        int i = range.Start.Value;
        int lessEnd = range.Start.Value;
        int greaterBegin = range.End.Value;
        int pivot = values[RandomRange(range)];

        while (i < greaterBegin)
        {
            if (values[i] < pivot)
                Swap(ref values[lessEnd++], ref values[i++]);
            else if (values[i] > pivot)
                Swap(ref values[i], ref values[--greaterBegin]);
            else
                i++;
        }

        int middleBegin = lessEnd;
        int middleEnd = greaterBegin;
        return middleBegin..middleEnd;
    }

    private static void Swap<T>(ref T value1, ref T value2)
    {
        (value1, value2) = (value2, value1);
    }

}

