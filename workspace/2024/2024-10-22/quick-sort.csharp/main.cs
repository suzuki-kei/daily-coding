using System;
using System.Collections.Generic;

class Application
{

    private static readonly Random random = new();

    static void Main()
    {
        var values = GenerateRandomValues(20);
        PrintList(values);
        QuickSort(values);
        PrintList(values);
    }

    private static int[] GenerateRandomValues(int n)
    {
        var values = new int[n];

        for (var i = 0; i < n; i++)
            values[i] = random.Next(10, 99);

        return values;
    }

    private static void PrintList(IReadOnlyList<int> list)
    {
        var joined = String.Join(" ", list);
        var sorted = IsSorted(list) ? "sorted" : "not sorted";
        Console.WriteLine("{0} ({1})", joined, sorted);
    }

    private static bool IsSorted(IReadOnlyList<int> list)
    {
        for (var i = 0; i < list.Count - 1; i++)
            if (list[i] > list[i + 1])
                return false;

        return true;
    }

    private static void QuickSort(IList<int> list)
    {
        QuickSort(list, 0, list.Count - 1);
    }

    private static void QuickSort(IList<int> list, int lower, int upper)
    {
        var incrementIndex = lower;
        var decrementIndex = upper;
        var pivot = list[random.Next(lower, upper)];

        while (incrementIndex <= decrementIndex)
        {
            while (list[incrementIndex] < pivot)
                incrementIndex++;
            while (list[decrementIndex] > pivot)
                decrementIndex--;
            if (incrementIndex <= decrementIndex)
                Swap(list, incrementIndex++, decrementIndex--);
        }

        if (lower < decrementIndex)
            QuickSort(list, lower, decrementIndex);
        if (incrementIndex < upper)
            QuickSort(list, incrementIndex, upper);
    }

    private static void Swap(IList<int> list, int index1, int index2)
    {
        (list[index1], list[index2]) = (list[index2], list[index1]);
    }

}

