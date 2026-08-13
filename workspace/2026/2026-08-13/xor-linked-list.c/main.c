#include "xor-linked-list.h"
#include <assert.h>
#include <stdio.h>

#define TEST_WITH_TRACE(test) \
    {                               \
        printf("==== " #test "\n"); \
        test();                     \
    }

void test_new(void);
void test_free(void);
void test_clear(void);
void test_length(void);
void test_print(void);
void test_begin(void);
void test_current(void);
void test_prev(void);
void test_next(void);
void test_insert_before(void);
void test_insert_after(void);
void test_delete(void);

int main(void)
{
    TEST_WITH_TRACE(test_new);
    TEST_WITH_TRACE(test_free);
    TEST_WITH_TRACE(test_clear);
    TEST_WITH_TRACE(test_length);
    TEST_WITH_TRACE(test_print);
    TEST_WITH_TRACE(test_begin);
    TEST_WITH_TRACE(test_current);
    TEST_WITH_TRACE(test_prev);
    TEST_WITH_TRACE(test_next);
    TEST_WITH_TRACE(test_insert_before);
    TEST_WITH_TRACE(test_insert_after);
    TEST_WITH_TRACE(test_delete);
    return 0;
}

void test_new(void)
{
    List *list = XorLinkedList_new();
    assert(list->head == NULL);

    XorLinkedList_free(list);
}

void test_free(void)
{
    {
        List *list = NULL;
        XorLinkedList_free(list);
    }

    {
        List *list = XorLinkedList_new();
        XorLinkedList_free(list);
    }
}

void test_clear(void)
{
    for (int n = 0; n < 10; n++)
    {
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);

        for (int i = 0; i < n; i++)
            XorLinkedList_insert_before(&it, i);

        XorLinkedList_clear(list);
        assert(list->head == NULL);

        XorLinkedList_free(list);
    }
}

void test_length(void)
{
    List *list = XorLinkedList_new();

    Iterator it = XorLinkedList_begin(list);
    assert(XorLinkedList_length(list) == 0);

    XorLinkedList_insert_after(&it, 1);
    assert(XorLinkedList_length(list) == 1);

    XorLinkedList_insert_after(&it, 2);
    assert(XorLinkedList_length(list) == 2);

    XorLinkedList_insert_after(&it, 3);
    assert(XorLinkedList_length(list) == 3);

    XorLinkedList_free(list);
}

void test_print(void)
{
    List *list = XorLinkedList_new();

    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_print(list);

    for (int i = 0; i < 3; i++)
    {
        XorLinkedList_insert_before(&it, i);
        XorLinkedList_print(list);
    }

    XorLinkedList_free(list);
}

void test_begin(void)
{
    List *list = XorLinkedList_new();

    Iterator it = XorLinkedList_begin(list);
    assert(it.prev == NULL && it.current == NULL && it.next == NULL);

    Node *node3 = XorLinkedList_insert_after(&it, 3);
    assert(it.prev == NULL && it.current == NULL && it.next == node3);
    assert(XorLinkedList_begin(list).current == node3);

    Node *node2 = XorLinkedList_insert_after(&it, 2);
    assert(it.prev == NULL && it.current == NULL && it.next == node2);
    assert(XorLinkedList_begin(list).current == node2);

    Node *node1 = XorLinkedList_insert_after(&it, 1);
    assert(it.prev == NULL && it.current == NULL && it.next == node1);
    assert(XorLinkedList_begin(list).current == node1);

    XorLinkedList_free(list);
}

void test_current(void)
{
    List *list = XorLinkedList_new();

    Iterator it = XorLinkedList_begin(list);
    assert(XorLinkedList_current(&it) == NULL);

    Node *node1 = XorLinkedList_insert_after(&it, 1);
    assert(XorLinkedList_current(&it) == NULL);
    XorLinkedList_next(&it);
    assert(XorLinkedList_current(&it) == node1);

    Node *node2 = XorLinkedList_insert_after(&it, 2);
    assert(XorLinkedList_current(&it) == node1);
    XorLinkedList_next(&it);
    assert(XorLinkedList_current(&it) == node2);

    Node *node3 = XorLinkedList_insert_after(&it, 3);
    assert(XorLinkedList_current(&it) == node2);
    XorLinkedList_next(&it);
    assert(XorLinkedList_current(&it) == node3);

    XorLinkedList_free(list);
}

void test_prev(void)
{
    List *list = XorLinkedList_new();
    Iterator it = XorLinkedList_begin(list);

    Node *node1 = XorLinkedList_insert_before(&it, 1);
    assert(XorLinkedList_prev(&it) == node1);

    Node *node2 = XorLinkedList_insert_before(&it, 2);
    assert(XorLinkedList_prev(&it) == node2);

    Node *node3 = XorLinkedList_insert_before(&it, 3);
    assert(XorLinkedList_prev(&it) == node3);

    XorLinkedList_free(list);
}

void test_next(void)
{
    List *list = XorLinkedList_new();
    Iterator it = XorLinkedList_begin(list);

    Node *node1 = XorLinkedList_insert_after(&it, 1);
    assert(XorLinkedList_next(&it) == node1);

    Node *node2 = XorLinkedList_insert_after(&it, 2);
    assert(XorLinkedList_next(&it) == node2);

    Node *node3 = XorLinkedList_insert_after(&it, 3);
    assert(XorLinkedList_next(&it) == node3);

    XorLinkedList_free(list);
}

void test_insert_before(void)
{
    List *list = XorLinkedList_new();
    Iterator it = XorLinkedList_begin(list);

    Node *node3 = XorLinkedList_insert_before(&it, 3);
    assert(node3 != NULL);
    assert(list->head == node3);

    XorLinkedList_prev(&it);

    Node *node1 = XorLinkedList_insert_before(&it, 1);
    assert(node1 != NULL);
    assert(list->head == node1);

    Node *node2 = XorLinkedList_insert_before(&it, 2);
    assert(node2 != NULL);
    assert(list->head == node1);

    XorLinkedList_free(list);
}

void test_insert_after(void)
{
    List *list = XorLinkedList_new();
    Iterator it = XorLinkedList_begin(list);

    Node *node3 = XorLinkedList_insert_after(&it, 3);
    assert(node3 != NULL);
    assert(list->head == node3);

    Node *node1 = XorLinkedList_insert_after(&it, 1);
    assert(node1 != NULL);
    assert(list->head == node1);

    XorLinkedList_next(&it);

    Node *node2 = XorLinkedList_insert_after(&it, 2);
    assert(node2 != NULL);
    assert(list->head == node1);

    XorLinkedList_free(list);
}

void test_delete(void)
{
    List *list = XorLinkedList_new();
    Iterator it = XorLinkedList_begin(list);
    Node *node3 = XorLinkedList_insert_after(&it, 3);
    Node *node2 = XorLinkedList_insert_after(&it, 2);
    Node *node1 = XorLinkedList_insert_after(&it, 1);

    assert(XorLinkedList_delete(&it) == 0);
    assert(it.prev == NULL && it.current == NULL && it.next == node1);

    XorLinkedList_next(&it);
    XorLinkedList_next(&it);
    assert(it.prev == node1 && it.current == node2 && it.next == node3);

    assert(XorLinkedList_delete(&it) == 1);
    assert(it.prev == node1 && it.current == node3 && it.next == NULL);

    assert(XorLinkedList_delete(&it) == 1);
    assert(it.prev == node1 && it.current == NULL && it.next == NULL);

    XorLinkedList_prev(&it);
    assert(it.prev == NULL && it.current == node1 && it.next == NULL);

    assert(XorLinkedList_delete(&it) == 1);
    assert(it.prev == NULL && it.current == NULL && it.next == NULL);

    XorLinkedList_free(list);
}

