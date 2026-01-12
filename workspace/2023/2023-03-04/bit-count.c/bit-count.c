#include <stdio.h>

int bit_count(int x);

int main(void)
{
    int i;

    for (i = 0; i <= 32; i++)
        printf("bit_count(%d) = %d\n", i, bit_count(i));
}

int bit_count(int x)
{
    x = (x & 0x55555555) + ((x >>  1) & 0x55555555);
    x = (x & 0x33333333) + ((x >>  2) & 0x33333333);
    x = (x & 0x0F0F0F0F) + ((x >>  4) & 0x0F0F0F0F);
    x = (x & 0x00FF00FF) + ((x >>  8) & 0x00FF00FF);
    x = (x & 0x0000FFFF) + ((x >> 16) & 0x0000FFFF);
    return x;
}

