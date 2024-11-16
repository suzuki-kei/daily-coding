using System.Collections.Generic;
using System.Linq;
using System;

class Application
{

    private static readonly Random random = new();

    static void Main()
    {
        int[] values = GenerateRandomValues(20);
        PrintList(values);
        QuickSort(values);
        PrintList(values);
    }

    private static int[] GenerateRandomValues(int n)
    {
        return Enumerable.Range(0, n).Select(_ => random.Next(10, 99)).ToArray(); }

    private static void PrintList(IReadOnlyList<int> list)
    {
        var joined = String.Join(" ", list);

        if (IsSorted(list))
            System.Console.WriteLine("{0} (sorted)", joined);
        else
            System.Console.WriteLine("{0} (not sorted)", joined);
    }

    private static bool IsSorted(IReadOnlyList<int> list)
    {
        for (int i = 0; i < list.Count - 1; i++)
            if (list[i] > list[i + 1])
                return false;

        return true;
    }

    private static void QuickSort(int[] values)
    {
        QuickSort(values, 0, values.Length - 1);
    }

    private static void QuickSort(int[] values, int lower, int upper)
    {
        int incrementIndex = lower;
        int decrementIndex = upper;
        int pivot = values[random.Next(lower, upper)];

        while (incrementIndex <= decrementIndex)
        {
            while (values[incrementIndex] < pivot)
                incrementIndex++;
            while (values[decrementIndex] > pivot)
                decrementIndex--;
            if (incrementIndex <= decrementIndex)
                Swap(values, incrementIndex++, decrementIndex--);
        }

        if (lower < decrementIndex)
            QuickSort(values, lower, decrementIndex);
        if (incrementIndex < upper)
            QuickSort(values, incrementIndex, upper);
    }

    private static void Swap(int[] values, int index1, int index2)
    {
        (values[index1], values[index2]) = (values[index2], values[index1]);
    }

}

