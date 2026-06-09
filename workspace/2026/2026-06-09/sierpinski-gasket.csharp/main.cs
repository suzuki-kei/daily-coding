class Application
{

    static void Main()
    {
        int size = 32;

        for (int y = 0; y <= size; y++)
        {
            for (int x = 0; x <= size; x++)
            {
                if ((x & y) == 0)
                    System.Console.Write("＊");
                else
                    System.Console.Write("　");
            }
            System.Console.WriteLine();
        }
    }

}

