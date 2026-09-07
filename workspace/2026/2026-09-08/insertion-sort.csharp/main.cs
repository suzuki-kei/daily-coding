using static System.Linq.Enumerable;

class Application
{

    private static readonly System.Random random = new();

    static void Main()
    {
        int[] array = GenerateRandomValues(10, 99, 20);
        PrintArray(array);
        InsertionSort(array);
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

    private static void InsertionSort(int[] array)
    {
        for (int end = 1; end < array.Length; end++)
        {
            int i = end;
            int value = array[end];

            while (i >= 1 && value < array[i - 1])
            {
                array[i] = array[i - 1];
                i--;
            }

            array[i] = value;
        }
    }

}

