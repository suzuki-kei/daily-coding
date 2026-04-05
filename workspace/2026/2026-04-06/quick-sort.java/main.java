import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

class Application
{

    public static void main(String[] arguments)
    {
        demonstration("partition 2-way", Application::partition2Way);
        demonstration("partition 3-way", Application::partition3Way);
    }

    private static record PartitionResult(int leftUpper, int rightLower)
    {
    }

    @FunctionalInterface
    private interface Partition
    {
        public PartitionResult apply(int[] array, int lower, int upper);
    }

    private static void demonstration(String label, Partition partition)
    {
        System.out.printf("==== %s\n", label);

        int[] array = generateRandomValues(20);
        printArray(array);
        quickSort(array, partition);
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

    private static void quickSort(int[] array, Partition partition)
    {
        if (array.length <= 1)
            return;

        quickSort(array, 0, array.length - 1, partition);
    }

    private static void quickSort(int[] array, int lower, int upper, Partition partition)
    {
        if (lower >= upper)
            return;

        PartitionResult result = partition.apply(array, lower, upper);
        quickSort(array, lower, result.leftUpper(), partition);
        quickSort(array, result.rightLower(), upper, partition);
    }

    private static PartitionResult partition2Way(int[] array, int lower, int upper)
    {
        int incrementIndex = lower;
        int decrementIndex = upper;
        int pivot = array[randomRange(lower, upper)];

        while (incrementIndex <= decrementIndex)
        {
            while (array[incrementIndex] < pivot)
                incrementIndex++;
            while (array[decrementIndex] > pivot)
                decrementIndex--;
            if (incrementIndex <= decrementIndex)
                swap(array, incrementIndex++, decrementIndex--);
        }

        return new PartitionResult(decrementIndex, incrementIndex);
    }

    private static PartitionResult partition3Way(int[] array, int lower, int upper)
    {
        int lessEnd = lower;
        int incrementIndex = lower;
        int decrementIndex = upper;
        int pivot = array[randomRange(lower, upper)];

        while (incrementIndex <= decrementIndex)
        {
            if (array[incrementIndex] < pivot)
                swap(array, lessEnd++, incrementIndex++);
            else if (array[incrementIndex] > pivot)
                swap(array, incrementIndex, decrementIndex--);
            else
                incrementIndex++;
        }

        return new PartitionResult(lessEnd - 1, incrementIndex);
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

