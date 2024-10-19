using System;
using System.Collections.Generic;

class Application
{

    static readonly Random random = new();

    static void Main()
    {
        var values = GenerateRandomValues(20);
        PrintArray(values);
        QuickSort(values);
        PrintArray(values);
    }

    private static int[] GenerateRandomValues(int n)
    {
        var values = new int[n];

        for (var i = 0; i < n; i++)
            values[i] = random.Next(10, 99);

        return values;
    }

    private static void PrintArray(IReadOnlyList<int> values)
    {
        Console.WriteLine(
            "{0} {1}",
            String.Join(" ", values),
            IsSorted(values) ? "(sorted)" : "(not sorted)");
    }

    private static bool IsSorted(IReadOnlyList<int> values)
    {
        for (var i = 0; i < values.Count - 1; i++)
            if (values[i] > values[i + 1])
                return false;

        return true;
    }

    private static void QuickSort(IList<int> values)
    {
        QuickSort(values, 0, values.Count - 1);
    }

    private static void QuickSort(IList<int> values, int lower, int upper)
    {
        var incrementIndex = lower;
        var decrementIndex = upper;
        var pivot = values[random.Next(lower, upper)];

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

    private static void Swap(IList<int> values, int index1, int index2)
    {
        (values[index1], values[index2]) = (values[index2], values[index1]);
    }

}

