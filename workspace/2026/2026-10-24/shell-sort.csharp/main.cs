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
        ShellSort(values);
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

    private static void ShellSort(int[] values)
    {
        for (int gap = ToInitialGap(values.Length); 1 <= gap; gap /= 3)
        {
            for (int end = gap; end < values.Length; end++)
            {
                int i = end;
                int value = values[end];

                while (gap <= i && value < values[i - gap])
                {
                    values[i] = values[i - gap];
                    i -= gap;
                }

                values[i] = value;
            }
        }
    }

    private static int ToInitialGap(int n)
    {
        int gap = 1;

        while (gap * 3 + 1 < n)
            gap = gap * 3 + 1;

        return gap;
    }

}

