using Console = System.Console;
using Random = System.Random;
using static System.Linq.Enumerable;

class Application
{

    private readonly struct PartitionResult
    {
        public int LeftUpper { get; }
        public int RightLower { get; }

        public PartitionResult(int leftUpper, int rightLower)
        {
            LeftUpper = leftUpper;
            RightLower = rightLower;
        }
    }

    private delegate PartitionResult Partition(int[] array, int lower, int upper);

    private static readonly Random random = new();

    static void Main()
    {
        Demonstration("partition 2-way", Partition2way);
        Demonstration("partition 3-way", Partition3way);
    }

    private static void Demonstration(string label, Partition partition)
    {
        Console.WriteLine("==== {0}", label);
        int[] array = GenerateRandomValues(20);
        PrintArray(array);
        QuickSort(array, partition);
        PrintArray(array);
    }

    private static int[] GenerateRandomValues(int n)
    {
        return Range(0, n).Select(_ => random.Next(10, 100)).ToArray();
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
        for (int i = 0; i < array.Length - 1; i++)
            if (array[i] > array[i + 1])
                return false;

        return true;
    }

    private static void QuickSort(int[] array, Partition partition)
    {
        if (array.Length <= 1)
            return;

        QuickSort(array, 0, array.Length - 1, partition);
    }

    private static void QuickSort(int[] array, int lower, int upper, Partition partition)
    {
        if (lower >= upper)
            return;

        PartitionResult result = partition(array, lower, upper);
        QuickSort(array, lower, result.LeftUpper, partition);
        QuickSort(array, result.RightLower, upper, partition);
    }

    private static PartitionResult Partition2way(int[] array, int lower, int upper)
    {
        int incrementIndex = lower;
        int decrementIndex = upper;
        int pivot = RandomSelect(array, lower, upper);

        while (incrementIndex <= decrementIndex)
        {
            while (array[incrementIndex] < pivot)
                incrementIndex++;
            while (array[decrementIndex] > pivot)
                decrementIndex--;
            if (incrementIndex <= decrementIndex)
                Swap(array, incrementIndex++, decrementIndex--);

        }

        return new PartitionResult(decrementIndex, incrementIndex);
    }

    private static PartitionResult Partition3way(int[] array, int lower, int upper)
    {
        int lessEnd = lower;
        int incrementIndex = lower;
        int decrementIndex = upper;
        int pivot = RandomSelect(array, lower, upper);

        while (incrementIndex <= decrementIndex)
        {
            if (array[incrementIndex] < pivot)
                Swap(array, lessEnd++, incrementIndex++);
            else if (array[incrementIndex] > pivot)
                Swap(array, incrementIndex, decrementIndex--);
            else
                incrementIndex++;
        }

        return new PartitionResult(lessEnd - 1, incrementIndex);
    }

    private static int RandomSelect(int[] array, int lower, int upper)
    {
        return array[random.Next(lower, upper + 1)];
    }

    private static void Swap(int[] array, int index1, int index2)
    {
        int temporary = array[index1];
        array[index1] = array[index2];
        array[index2] = temporary;
    }

}

