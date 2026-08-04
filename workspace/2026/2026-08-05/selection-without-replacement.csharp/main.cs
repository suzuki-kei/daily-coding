
class Application
{

    static void Main()
    {
        int[] array = SelectionWithoutReplacement(10, 99, 20);
        System.Console.WriteLine(string.Join(" ", array));
    }

    static int[] SelectionWithoutReplacement(int min, int max, int n)
    {
        int[] array = new int[n];
        int nSelected = 0;

        for (int value = min; value <= max; value++)
        {
            double numerator = n - nSelected;
            double denominator = max - value + 1;
            double r = System.Random.Shared.NextDouble();

            if (r < numerator / denominator)
                array[nSelected++] = value;
        }

        return array;
    }

}

