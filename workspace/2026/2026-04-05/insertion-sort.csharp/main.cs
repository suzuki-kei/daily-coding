using Console = System.Console;
using Random = System.Random;
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

    private static readonly Random random = new();

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

    private static void InsertionSort(int[] array)
    {
        for (int end = 1; end < array.Length; end++)
        {
            int insertionIndex = end;
            int insertionValue = array[insertionIndex];

            while (1 <= insertionIndex && insertionValue < array[insertionIndex - 1])
            {
                array[insertionIndex] = array[insertionIndex - 1];
                insertionIndex--;
            }

            array[insertionIndex] = insertionValue;
        }
    }
}

