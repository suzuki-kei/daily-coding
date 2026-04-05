import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

class Application
{

    public static void main(String[] arguments)
    {
        int[] array = generateRandomValues(20);
        printArray(array);
        selectionSort(array);
        printArray(array);
    }

    private static int[] generateRandomValues(int n)
    {
        return IntStream.range(0, n)
                        .map(_ -> randomRange(10, 99))
                        .toArray();
    }

    private static void printArray(int[] array)
    {
        String formatted = Arrays.stream(array)
                                 .mapToObj(String::valueOf)
                                 .collect(Collectors.joining(" "));

        if (isSorted(array))
            System.out.printf("%s (sorted)\n", formatted);
        else
            System.out.printf("%s (not sorted)\n", formatted);
    }

    private static boolean isSorted(int[] array)
    {
        return IntStream.range(0, array.length - 1)
                        .allMatch(i -> array[i] <= array[i + 1]);
    }

    private static void selectionSort(int[] array)
    {
        for (int begin = 0; begin < array.length - 1; begin++)
        {
            int minimumIndex = begin;

            for (int i = begin + 1; i < array.length; i++)
                if (array[i] < array[minimumIndex])
                    minimumIndex = i;

            swap(array, begin, minimumIndex);
        }
    }

    private static int randomRange(int min, int max)
    {
        return (int) (Math.random() * (max - min + 1)) + min;
    }

    private static void swap(int[] array, int index1, int index2)
    {
        int temporary = array[index1];
        array[index1] = array[index2];
        array[index2] = temporary;
    }

}

