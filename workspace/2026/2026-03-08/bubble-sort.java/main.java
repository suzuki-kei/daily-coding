import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

class Application
{

    public static void main(String[] arguments)
    {
        int[] array = generateRandomValues(20);
        printArray(array);
        bubbleSort(array);
        printArray(array);
    }

    private static int[] generateRandomValues(int n)
    {
        return IntStream.range(0, n)
                        .map(_ -> (int) (Math.random() * 90) + 10)
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

    private static void bubbleSort(int[] array)
    {
        for (int unsortedLength = array.length; unsortedLength > 0; unsortedLength--)
            for (int i = 0; i < unsortedLength - 1; i++)
                if (array[i] > array[i + 1])
                    swap(array, i, i + 1);
    }

    private static void swap(int[] array, int index1, int index2)
    {
        int temporary = array[index1];
        array[index1] = array[index2];
        array[index2] = temporary;
    }

}

