#include "xor-linked-list.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

void demonstration(void);

int main(void)
{
    demonstration();
    return 0;
}

void demonstration(void)
{
    {
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);
        XorLinkedList_insert_before(&it, 3);
        XorLinkedList_prev(&it);
        XorLinkedList_insert_after(&it, 6);
        XorLinkedList_insert_after(&it, 5);
        XorLinkedList_insert_after(&it, 4);

        while (XorLinkedList_prev(&it) != NULL);
        assert(it.current == NULL);

        for (int value = 1; value <= 6; value++)
        {
            XorLinkedList_next(&it);
            assert(it.current->value == value);
        }

        while (XorLinkedList_next(&it) != NULL);
        assert(it.current == NULL);

        for (int value = 6; value >= 1; value--)
        {
            XorLinkedList_prev(&it);
            assert(it.current->value == value);
        }

        XorLinkedList_print(list);
        XorLinkedList_free(list);
    }

    {
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_after(&it, 6);
        XorLinkedList_insert_after(&it, 5);
        XorLinkedList_insert_after(&it, 4);
        XorLinkedList_next(&it);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);
        XorLinkedList_insert_before(&it, 3);

        while (XorLinkedList_prev(&it) != NULL);
        assert(it.current == NULL);

        for (int value = 1; value <= 6; value++)
        {
            XorLinkedList_next(&it);
            assert(it.current->value == value);
        }

        while (XorLinkedList_next(&it) != NULL);
        assert(it.current == NULL);

        for (int value = 6; value >= 1; value--)
        {
            XorLinkedList_prev(&it);
            assert(it.current->value == value);
        }

        XorLinkedList_print(list);
        XorLinkedList_free(list);
    }
}

