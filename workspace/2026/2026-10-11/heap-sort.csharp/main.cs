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
        HeapSort(array);
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

    private static void HeapSort(int[] array)
    {
        HeapBuild(array);
        HeapPopAll(array);
    }

    private static void HeapBuild(int[] array)
    {
        for (int i = array.Length / 2 - 1; 0 <= i; i--)
            HeapShiftDown(array, array.Length, i);
    }

    private static void HeapPopAll(int[] array)
    {
        for (int i = array.Length - 1; 1 <= i; i--)
        {
            Swap(ref array[i], ref array[0]);
            HeapShiftDown(array, i, 0);
        }
    }

    private static void HeapShiftDown(int[] array, int n, int i)
    {
        while (i * 2 + 1 < n)
        {
            int maximumIndex = i;
            int leftIndex = i * 2 + 1;
            int rightIndex = i * 2 + 2;

            if (leftIndex < n && array[leftIndex] > array[maximumIndex])
                maximumIndex = leftIndex;

            if (rightIndex < n && array[rightIndex] > array[maximumIndex])
                maximumIndex = rightIndex;

            if (i == maximumIndex)
                break;

            Swap(ref array[i], ref array[maximumIndex]);
            i = maximumIndex;
        }
    }

    private static void Swap<T>(ref T value1, ref T value2)
    {
        (value1, value2) = (value2, value1);
    }

}

