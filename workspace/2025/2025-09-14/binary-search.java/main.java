import java.util.Arrays;
import java.util.stream.Collectors;

class Application
{

    public static void main(String[] arguments)
    {
        int[] values = generateRandomAscendingValues(20);
        System.out.println(toString(values));

        int lower = values[0] - 1;
        int upper = values[values.length - 1] + 1;

        for (int target = lower; target <= upper; target++)
        {
            int index = binarySearch(values, target);
            System.out.printf("target=%d, index=%d\n", target, index);
        }
    }

    private static int[] generateRandomAscendingValues(int n)
    {
        int value = 9;
        int[] values = new int[n];

        for (int i = 0; i < n; i++)
        {
            value += (int) (Math.random() * 5) + 1;
            values[i] = value;
        }

        return values;
    }

    private static String toString(int[] values)
    {
        return Arrays.stream(values).mapToObj(String::valueOf).collect(Collectors.joining(" "));
    }

    private static int binarySearch(int[] values, int target)
    {
        return binarySearch(values, target, 0, values.length - 1);
    }

    private static int binarySearch(int[] values, int target, int lower, int upper)
    {
        if (lower > upper)
            return -1;

        int center = (lower + upper) / 2;

        if (target == values[center])
            return center;

        if (target < values[center])
            return binarySearch(values, target, lower, center - 1);
        else
            return binarySearch(values, target, center + 1, upper);
    }

}

