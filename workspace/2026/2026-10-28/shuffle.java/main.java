import java.util.Arrays;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

class Main
{

    public static void main()
    {
        int[] array = sequence(0, 9);
        printArray(array);
        shuffle(array);
        printArray(array);
    }

    private static int[] sequence(int min, int max)
    {
        return IntStream.range(min, max).toArray();
    }

    private static void printArray(int[] array)
    {
        System.out.println(toString(array));
    }

    private static String toString(int[] array)
    {
        return Arrays.stream(array)
                     .mapToObj(String::valueOf)
                     .collect(Collectors.joining(" "));
    }

    private static void shuffle(int[] array)
    {
        for (int i = 0; i < array.length - 1; i++)
        {
            int target = randomRange(i, array.length);
            swap(array, i, target);
        }
    }

    private static int randomRange(int begin, int end)
    {
        return ThreadLocalRandom.current().nextInt(begin, end);
    }

    private static void swap(int[] array, int index1, int index2)
    {
        int temporary = array[index1];
        array[index1] = array[index2];
        array[index2] = temporary;
    }

}

