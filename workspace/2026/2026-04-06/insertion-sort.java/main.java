import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

class Application
{

    public static void main(String[] arguments)
    {
        int[] array = generateRandomValues(20);
        printArray(array);
        insertionSort(array);
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

    private static void insertionSort(int[] array)
    {
        for (int end = 1; end < array.length; end++)
        {
            int insertionIndex = end;
            int insertionValue = array[end];

            while (insertionIndex >= 1 && insertionValue < array[insertionIndex - 1])
            {
                array[insertionIndex] = array[insertionIndex - 1];
                insertionIndex--;
            }

            array[insertionIndex] = insertionValue;
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

