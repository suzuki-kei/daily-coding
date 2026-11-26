using System;
using System.Linq;

class Application
{

    private static Random random = new();

    static void Main()
    {
        int[] values = Enumerable.Range(0, 10).ToArray();
        Console.WriteLine("{0}", string.Join(" ", values));
        Shuffle(values);
        Console.WriteLine("{0}", string.Join(" ", values));
    }

    private static void Shuffle(int[] values)
    {
        for (int i = 0; i < values.Length - 1; i++)
        {
            int target = random.Next(i, values.Length);
            (values[i], values[target]) = (values[target], values[i]);
        }
    }

}

