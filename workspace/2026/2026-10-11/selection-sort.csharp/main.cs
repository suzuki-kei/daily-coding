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
        SelectionSort(array);
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

    private static void SelectionSort(int[] array)
    {
        for (int begin = 0; begin + 1 < array.Length; begin++)
        {
            int minimumIndex = begin;

            for (int i = begin + 1; i < array.Length; i++)
                if (array[i] < array[minimumIndex])
                    minimumIndex = i;

            Swap(ref array[begin], ref array[minimumIndex]);
        }
    }

    private static void Swap<T>(ref T value1, ref T value2)
    {
        (value1, value2) = (value2, value1);
    }

}

