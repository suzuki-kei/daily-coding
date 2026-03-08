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

    private static void insertionSort(int[] array)
    {
        for (int sortedLength = 1; sortedLength < array.length; sortedLength++)
        {
            int insertionIndex = sortedLength;
            int insertionValue = array[sortedLength];

            while (insertionIndex > 0 && insertionValue < array[insertionIndex - 1])
            {
                array[insertionIndex] = array[insertionIndex - 1];
                insertionIndex--;
            }

            array[insertionIndex] = insertionValue;
        }
    }

}

