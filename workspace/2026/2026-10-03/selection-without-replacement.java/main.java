import java.util.Arrays;
import java.util.stream.Collectors;

class Main
{

    public static void main(String[] arguments)
    {
        int[] array = selectionWithoutReplacement(10, 99, 20);
        System.out.println(Arrays.stream(array).mapToObj(String::valueOf).collect(Collectors.joining(" ")));
    }

    private static int[] selectionWithoutReplacement(int min, int max, int n)
    {
        int[] values = new int[n];
        int nSelected = 0;

        for (int x = min; x <= max; x++)
        {
            int nRemaining = n - nSelected;
            int nCandidatesRemaining = max - x + 1;
            double selectionProbability = (double) nRemaining / (double) nCandidatesRemaining;

            if (Math.random() < selectionProbability)
                values[nSelected++] = x;
        }

        return values;
    }

}

