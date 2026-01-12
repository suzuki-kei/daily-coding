#include <stdio.h>

int bit_count(int value);

int main(void)
{
    int i;

    for (i = 0; i <= 32; i++)
        printf("bit_count(%2d) = %d\n", i, bit_count(i));
}

int bit_count(int value)
{
    value = (value & 0x55555555) + (value >>  1 & 0x55555555);
    value = (value & 0x33333333) + (value >>  2 & 0x33333333);
    value = (value & 0x0F0F0F0F) + (value >>  4 & 0x0F0F0F0F);
    value = (value & 0x00FF00FF) + (value >>  8 & 0x00FF00FF);
    value = (value & 0x0000FFFF) + (value >> 16 & 0x0000FFFF);
    return value;
}

