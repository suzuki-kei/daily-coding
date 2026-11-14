import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Main
{

    static void main()
    {
        System.out.println(Arrays.toString(selectionWithoutReplacement(20, 0, 9)));
        System.out.println(Arrays.toString(selectionWithoutReplacement(20, 10, 99)));
    }

    static int[] selectionWithoutReplacement(int n, int min, int max)
    {
        List<Integer> values = new ArrayList<Integer>();

        for (int value = min; value <= max; value++)
        {
            int nRemaining = n - values.size();
            int nCandidatesRemaining = max - value + 1;
            double selectionProbability = nRemaining / (double) nCandidatesRemaining;

            if (Math.random() < selectionProbability)
                values.add(value);
        }

        return values.stream().mapToInt(Integer::intValue).toArray();
    }

}

