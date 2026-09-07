using static System.Linq.Enumerable;

class Application
{

    private static readonly System.Random random = new();

    static void Main()
    {
        int[] array = GenerateRandomValues(10, 99, 20);
        PrintArray(array);
        BubbleSort(array);
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

    private static void BubbleSort(int[] array)
    {
        for (int last = array.Length - 1; last >= 0; last--)
            for (int i = 0; i + 1 <= last; i++)
                if (array[i] > array[i + 1])
                    Swap(array, i, i + 1);
    }

    private static void Swap(int[] array, int index1, int index2)
    {
        (array[index1], array[index2]) = (array[index2], array[index1]);
    }

}

