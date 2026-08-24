import java.util.Arrays;
import java.util.stream.Collectors;

class Application
{

    public static void main(String[] arguments)
    {
        int[] values = selectionWithoutReplacement(10, 99, 20);
        System.out.println(toString(values));

        int minTarget = values[0] - 1;
        int maxTarget = values[values.length - 1] + 1;

        for (int target = minTarget; target <= maxTarget; target++)
        {
            int index = binarySearch(values, target);
            System.out.format("target=%d, index=%d\n", target, index);
        }
    }

    private static int[] selectionWithoutReplacement(int min, int max, int n)
    {
        int[] values = new int[n];
        int nSelected = 0;

        for (int value = min; value <= max; value++)
        {
            int nRemaining = n - nSelected;
            int nCandidatesRemaining = max - value + 1;
            double selectionProbability = ((double) nRemaining) / nCandidatesRemaining;

            if (Math.random() < selectionProbability)
                values[nSelected++] = value;
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

    private static int binarySearch(int[] values, int target, int first, int last)
    {
        if (first > last)
            return -1;

        int center = (first + last) / 2;

        if (target == values[center])
            return center;

        if (target < values[center])
            return binarySearch(values, target, first, center - 1);
        else
            return binarySearch(values, target, center + 1, last);
    }

}

