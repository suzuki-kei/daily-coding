import java.util.stream.IntStream;

class Application
{

    public static void main(String[] arguments)
    {
        int[] values = generateRandomValues(20);
        printArray(values);
        quickSort(values);
        printArray(values);
    }

    private static int[] generateRandomValues(int n)
    {
        return IntStream.range(0, n).map(_ -> (int) (Math.random() * 90 + 10)).toArray();
    }

    private static void printArray(int[] values)
    {
        String separator = "";

        for (int value : values)
        {
            System.out.printf("%s%d", separator, value);
            separator = " ";
        }

        if (isSorted(values))
            System.out.println(" (sorted)");
        else
            System.out.println(" (not sorted)");
    }

    private static boolean isSorted(int[] values)
    {
        for (int i = 0; i < values.length - 1; i++)
            if (values[i] > values[i + 1])
                return false;

        return true;
    }

    private static void quickSort(int[] values)
    {
        quickSort(values, 0, values.length - 1);
    }

    private static void quickSort(int[] values, int lower, int upper)
    {
        int incrementIndex = lower;
        int decrementIndex = upper;
        int pivot = randomSelect(values, lower, upper);

        while (incrementIndex <= decrementIndex)
        {
            while (values[incrementIndex] < pivot)
                incrementIndex++;
            while (values[decrementIndex] > pivot)
                decrementIndex--;
            if (incrementIndex <= decrementIndex)
                swap(values, incrementIndex++, decrementIndex--);
        }

        if (lower < decrementIndex)
            quickSort(values, lower, decrementIndex);
        if (incrementIndex < upper)
            quickSort(values, incrementIndex, upper);
    }

    private static int randomSelect(int[] values, int lower, int upper)
    {
        return values[(int) (Math.random() % (upper - lower + 1)) + lower];
    }

    private static void swap(int[] values, int index1, int index2)
    {
        int temporary = values[index1];
        values[index1] = values[index2];
        values[index2] = temporary;
    }

}

