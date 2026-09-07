using static System.Linq.Enumerable;

class Application
{

    private static readonly System.Random random = new();

    static void Main()
    {
        int[] array = GenerateRandomValues(10, 99, 20);
        PrintArray(array);
        SelectionSort(array);
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

    private static void SelectionSort(int[] array)
    {
        for (int begin = 0; begin + 1 < array.Length; begin++)
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

