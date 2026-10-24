using System.Collections.Generic;
using System.Linq;
using System;

class Application
{

    private static Random random = new();

    static void Main()
    {
        int[] values = GenerateRandomValues(20, 10..100);
        PrintValues(values);
        MergeSort(values);
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

    private static void MergeSort(int[] values)
    {
        int[] buffer = new int[values.Length];
        int[] input = values;
        int[] output = buffer;

        for (int chunkSize = 1; chunkSize < values.Length; chunkSize *= 2)
        {
            for (int i = 0; i < values.Length; i += chunkSize * 2)
                Merge(
                    output,
                    i,
                    input,
                    i,
                    Math.Min(values.Length, i + chunkSize),
                    Math.Min(values.Length, i + chunkSize),
                    Math.Min(values.Length, i + chunkSize * 2));

            (input, output) = (output, input);
        }

        if (values == output)
            for (int i = 0; i < values.Length; i++)
                values[i] = buffer[i];
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

