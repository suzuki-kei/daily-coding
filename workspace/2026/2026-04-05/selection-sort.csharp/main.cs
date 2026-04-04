using Console = System.Console;
using Random = System.Random;
using static System.Linq.Enumerable;

class Application
{
    static void Main()
    {
        int[] array = GenerateRandomValues(20);
        PrintArray(array);
        SelectionSort(array);
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

    private static void SelectionSort(int[] array)
    {
        for (int begin = 0; begin < array.Length - 1; begin++)
        {
            int minimumIndex = begin;

            for (int i = begin + 1; i < array.Length; i++)
                if (array[i] < array[minimumIndex])
                    minimumIndex = i;

            Swap(array, begin, minimumIndex);
        }
    }

    private static void Swap(int[] array, int index1, int index2)
    {
        (array[index1], array[index2]) = (array[index2], array[index1]);
    }
}

