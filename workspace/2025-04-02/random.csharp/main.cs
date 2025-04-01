using System.Collections.Generic;
using System.Linq;
using System;

class Application
{

    private static readonly Random random = new();

    static void Main()
    {
        int[] values = GenerateRandomValues(20);
        System.Console.WriteLine("{0}", string.Join(" ", values));
    }

    private static int[] GenerateRandomValues(int n)
    {
        return Enumerable.Range(0, n).Select(_ => random.Next(10, 99)).ToArray();
    }

}

