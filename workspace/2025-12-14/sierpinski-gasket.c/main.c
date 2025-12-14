#include <stdio.h>

int main(void)
{
    for (int y = 0; y <= 32; y++)
    {
        for (int x = 0; x <= 32; x++)
            if ((x & y) == 0)
                printf("＊");
            else
                printf("　");
        printf("\n");
    }
}

