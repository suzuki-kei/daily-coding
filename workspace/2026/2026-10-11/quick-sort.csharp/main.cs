using Console = System.Console;
using Enumerable = System.Linq.Enumerable;
using Random = System.Random;
using Range = System.Range;
using static System.Linq.Enumerable;

class Application
{

    static void Main()
    {
        Demonstration("partition 2-way", Partition2Way);
        Demonstration("partition 3-way", Partition3Way);
    }

    private readonly struct PartitionResult
    {

        public int MiddleBegin
        {
            get;
        }

        public int MiddleEnd
        {
            get;
        }

        public PartitionResult(int middleBegin, int middleEnd)
        {
            MiddleBegin = middleBegin;
            MiddleEnd = middleEnd;
        }

    }

    private delegate PartitionResult Partition(int[] array, Range range);

    private static readonly Random random = new();

    private static void Demonstration(string label, Partition partition)
    {
        Console.WriteLine("==== {0}", label);

        int[] array = GenerateRandomValues(20, 10..100);
        PrintArray(array);
        QuickSort(array, partition);
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

    private static void PrintArray(in int[] array)
    {
        if (IsSorted(array))
            Console.WriteLine("{0} (sorted)", string.Join(" ", array));
        else
            Console.WriteLine("{0} (not sorted)", string.Join(" ", array));
    }

    private static bool IsSorted(in int[] array)
    {
        for (int i = 0; i + 1 < array.Length; i++)
            if (array[i] > array[i + 1])
                return false;

        return true;
    }

    private static void QuickSort(int[] array, Partition partition)
    {
        QuickSort(array, 0..array.Length, partition);
    }

    private static void QuickSort(int[] array, Range range, Partition partition)
    {
        int begin = range.Start.Value;
        int end = range.End.Value;

        while (begin < end)
        {
            PartitionResult result = partition(array, begin..end);
            int nLeft = result.MiddleBegin - begin;
            int nRight = end - result.MiddleEnd;

            if (nLeft <= nRight)
            {
                QuickSort(array, begin..result.MiddleBegin, partition);
                begin = result.MiddleEnd;
            }
            else
            {
                QuickSort(array, result.MiddleEnd..end, partition);
                end = result.MiddleBegin;
            }
        }
    }

    private static PartitionResult Partition2Way(int[] array, Range range)
    {
        int incrementIndex = range.Start.Value;
        int decrementIndex = range.End.Value - 1;
        int pivot = array[RandomRange(range)];

        while (incrementIndex <= decrementIndex)
        {
            while (array[incrementIndex] < pivot)
                incrementIndex++;

            while (array[decrementIndex] > pivot)
                decrementIndex--;

            if (incrementIndex <= decrementIndex)
                Swap(ref array[incrementIndex++], ref array[decrementIndex--]);
        }

        return new PartitionResult(decrementIndex + 1, incrementIndex);
    }

    private static PartitionResult Partition3Way(int[] array, Range range)
    {
        int i = range.Start.Value;
        int lessEnd = range.Start.Value;
        int greaterBegin = range.End.Value;
        int pivot = array[RandomRange(range)];

        while (i < greaterBegin)
            if (array[i] < pivot)
                Swap(ref array[lessEnd++], ref array[i++]);
            else if (array[i] > pivot)
                Swap(ref array[i], ref array[--greaterBegin]);
            else
                i++;

        return new PartitionResult(lessEnd, greaterBegin);
    }

    private static void Swap<T>(ref T value1, ref T value2)
    {
        (value1, value2) = (value2, value1);
    }

}

