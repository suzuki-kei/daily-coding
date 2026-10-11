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
        MergeSort(array);
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

    private static void MergeSort(int[] array)
    {
        int[] buffer = new int[array.Length];
        int[] input = array;
        int[] output = buffer;

        for (int chunkSize = 1; chunkSize < array.Length; chunkSize *= 2)
        {
            for (int i = 0; i < array.Length; i += chunkSize * 2)
                Merge(
                    output,
                    i,
                    input,
                    i,
                    Math.Min(array.Length, i + chunkSize),
                    Math.Min(array.Length, i + chunkSize),
                    Math.Min(array.Length, i + chunkSize * 2));
            Swap(ref input, ref output);
        }

        if (array == output)
            for (int i = 0; i < array.Length; i++)
                array[i] = buffer[i];
    }

    private static void Merge(
        int[] output, int outputIndex, IReadOnlyList<int> input, int begin1, int end1, int begin2, int end2)
    {
        while (begin1 < end1 && begin2 < end2)
            if (input[begin1] <= input[begin2])
                output[outputIndex++] = input[begin1++];
            else
                output[outputIndex++] = input[begin2++];

        while (begin1 < end1)
            output[outputIndex++] = input[begin1++];

        while (begin2 < end2)
            output[outputIndex++] = input[begin2++];
    }

    private static void Swap<T>(ref T value1, ref T value2)
    {
        (value1, value2) = (value2, value1);
    }

}

