using static System.Linq.Enumerable;

class Application
{

    static void Main()
    {
        Demonstration("partition 2-way", Partition2way);
        Demonstration("partition 3-way", Partition3way);
    }

    private readonly struct PartitionResult
    {

        public int LeftLast
        {
            get;
        }

        public int RightFirst
        {
            get;
        }

        public PartitionResult(int leftLast, int rightFirst)
        {
            LeftLast = leftLast;
            RightFirst = rightFirst;
        }

    }

    private delegate PartitionResult Partition(int[] array, int first, int last);

    private static readonly System.Random random = new();

    private static void Demonstration(string label, Partition partition)
    {
        System.Console.WriteLine("==== {0}", label);

        int[] array = GenerateRandomValues(10, 99, 20);
        PrintArray(array);
        QuickSort(array, partition);
        PrintArray(array);
    }

    private static int[] GenerateRandomValues(int min, int max, int n)
    {
        return Range(0, n).Select(_ => random.Next(min, max + 1)).ToArray();
    }

    private static void PrintArray(in int[] array)
    {
        if (IsSorted(array))
            System.Console.WriteLine("{0} (sorted)", string.Join(" ", array));
        else
            System.Console.WriteLine("{0} (not sorted)", string.Join(" ", array));
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
        QuickSort(array, 0, array.Length - 1, partition);
    }

    private static void QuickSort(int[] array, int first, int last, Partition partition)
    {
        while (first < last)
        {
            PartitionResult result = partition(array, first, last);
            int nLeft = result.LeftLast - first + 1;
            int nRight = last - result.RightFirst + 1;

            if (nLeft <= nRight)
            {
                QuickSort(array, first, result.LeftLast, partition);
                first = result.RightFirst;
            }
            else
            {
                QuickSort(array, result.RightFirst, last, partition);
                last = result.LeftLast;
            }
        }
    }

    private static PartitionResult Partition2way(int[] array, int first, int last)
    {
        int incrementIndex = first;
        int decrementIndex = last;
        int pivot = array[random.Next(first, last + 1)];

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

    private static PartitionResult Partition3way(int[] array, int first, int last)
    {
        int lessEnd = first;
        int incrementIndex = first;
        int decrementIndex = last;
        int pivot = array[random.Next(first, last + 1)];

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

    private static void Swap(int[] array, int index1, int index2)
    {
        (array[index1], array[index2]) = (array[index2], array[index1]);
    }

}

