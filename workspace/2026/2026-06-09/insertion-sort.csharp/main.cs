using static System.Linq.Enumerable;

class Application
{

    static void Main()
    {
        int[] array = GenerateRandomValues(20);
        PrintArray(array);
        InsertionSort(array);
        PrintArray(array);
    }

    private static readonly System.Random random = new();

    private static int[] GenerateRandomValues(int n)
    {
        return Range(0, n).Select(_ => random.Next(10, 100)).ToArray();
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

    private static void InsertionSort(int[] array)
    {
        for (int i = 1; i < array.Length; i++)
            Insert(array, i);
    }

    private static void Insert(int[] array, int i)
    {
        int value = array[i];

        while (i >= 1 && value < array[i - 1])
        {
            array[i] = array[i - 1];
            i--;
        }
        array[i] = value;
    }

}

