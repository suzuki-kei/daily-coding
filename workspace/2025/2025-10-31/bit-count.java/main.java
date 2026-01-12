
class Application
{

    public static void main(String[] arguments)
    {
        for (int i = 0; i <= 32; i++)
            System.out.printf("bitCount(%2d) = %d\n", i, bitCount(i));
    }

    private static int bitCount(int x)
    {
        x = (x & 0x55555555) + ((x >>  1) & 0x55555555);
        x = (x & 0x33333333) + ((x >>  2) & 0x33333333);
        x = (x & 0x0F0F0F0F) + ((x >>  4) & 0x0F0F0F0F);
        x = (x & 0x00FF00FF) + ((x >>  8) & 0x00FF00FF);
        x = (x & 0x0000FFFF) + ((x >> 16) & 0x0000FFFF);
        return x;
    }

}

