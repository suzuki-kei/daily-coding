#include "xor-linked-list.h"
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    List *list = NULL;

    if ((list = XorLinkedList_new()) == NULL)
    {
        fprintf(stderr, "allocation failed.\n");
        exit(1);
    }

    XorLinkedList_dump(list);

    for (int i = 0; i < 10; i++)
    {
        if (i % 2 == 0)
            XorLinkedList_insert_before(list, i);
        else
            XorLinkedList_insert_after(list, i);

        XorLinkedList_dump(list);
    }

    XorLinkedList_free(list);

    return 0;
}

