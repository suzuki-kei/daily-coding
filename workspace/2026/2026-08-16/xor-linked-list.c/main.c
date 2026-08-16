#include "xor-linked-list.h"
#include <assert.h>
#include <stdio.h>

#define RUN_TEST(test_case) \
    {                                       \
        printf("==== %s\n", #test_case);    \
        test_case();                        \
    }

void test_new();
void test_free();
void test_print();
void test_iterator();
void test_prev();
void test_next();
void test_before();
void test_after();
void test_delete();

int main(void)
{
    RUN_TEST(test_new);
    RUN_TEST(test_free);
    RUN_TEST(test_print);
    RUN_TEST(test_iterator);
    RUN_TEST(test_prev);
    RUN_TEST(test_next);
    RUN_TEST(test_before);
    RUN_TEST(test_after);
    RUN_TEST(test_delete);
    return 0;
}

void test_new()
{
    List *list = XorLinkedList_new();
    XorLinkedList_free(list);
}

void test_free()
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

void test_print()
{
    List *list = XorLinkedList_new();

    Iterator it = XorLinkedList_iterator(list);
    XorLinkedList_print(list);

    XorLinkedList_insert_before(&it, 1);
    XorLinkedList_print(list);

    XorLinkedList_insert_before(&it, 2);
    XorLinkedList_print(list);

    XorLinkedList_insert_before(&it, 3);
    XorLinkedList_print(list);

    XorLinkedList_free(list);
}

void test_iterator()
{
    List *list = XorLinkedList_new();

    Iterator it = XorLinkedList_iterator(list);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == NULL);

    XorLinkedList_insert_after(&it, 1);
    Iterator it1 = XorLinkedList_iterator(list);
    assert(it1.list == list);
    assert(it1.prev == NULL);
    assert(it1.current == list->head);
    assert(it1.current->value == 1);
    assert(it1.next == NULL);

    XorLinkedList_insert_after(&it, 2);
    Iterator it2 = XorLinkedList_iterator(list);
    assert(it2.list == list);
    assert(it2.prev == NULL);
    assert(it2.current == list->head);
    assert(it2.current->value == 2);
    assert(it2.next != NULL);
    assert(it2.next->value == 1);

    XorLinkedList_insert_after(&it, 3);
    Iterator it3 = XorLinkedList_iterator(list);
    assert(it3.list == list);
    assert(it3.prev == NULL);
    assert(it3.current == list->head);
    assert(it3.current->value == 3);
    assert(it3.next != NULL);
    assert(it3.next->value == 2);

    XorLinkedList_free(list);
}

void test_prev()
{
    List *list = XorLinkedList_new();
    Node *node = NULL;

    Iterator it = XorLinkedList_iterator(list);
    node = XorLinkedList_prev(&it);
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == NULL);

    Node *node1 = XorLinkedList_insert_before(&it, 1);
    Node *node2 = XorLinkedList_insert_before(&it, 2);
    Node *node3 = XorLinkedList_insert_before(&it, 3);

    node = XorLinkedList_prev(&it);
    assert(node == node3);
    assert(it.list == list);
    assert(it.prev == node2);
    assert(it.current == node3);
    assert(it.next == NULL);

    node = XorLinkedList_prev(&it);
    assert(node == node2);
    assert(it.list == list);
    assert(it.prev == node1);
    assert(it.current == node2);
    assert(it.next == node3);

    node = XorLinkedList_prev(&it);
    assert(node == node1);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == node1);
    assert(it.next == node2);

    node = XorLinkedList_prev(&it);
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == node1);

    node = XorLinkedList_prev(&it);
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == node1);

    XorLinkedList_free(list);
}

void test_next()
{
    List *list = XorLinkedList_new();
    Node *node = NULL;

    Iterator it = XorLinkedList_iterator(list);
    node = XorLinkedList_next(&it);
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == NULL);

    Node *node3 = XorLinkedList_insert_after(&it, 3);
    Node *node2 = XorLinkedList_insert_after(&it, 2);
    Node *node1 = XorLinkedList_insert_after(&it, 1);

    node = XorLinkedList_next(&it);
    assert(node == node1);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == node1);
    assert(it.next == node2);

    node = XorLinkedList_next(&it);
    assert(node == node2);
    assert(it.list == list);
    assert(it.prev == node1);
    assert(it.current == node2);
    assert(it.next == node3);

    node = XorLinkedList_next(&it);
    assert(node == node3);
    assert(it.list == list);
    assert(it.prev == node2);
    assert(it.current == node3);
    assert(it.next == NULL);

    node = XorLinkedList_next(&it);
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev == node3);
    assert(it.current == NULL);
    assert(it.next == NULL);

    node = XorLinkedList_next(&it);
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev == node3);
    assert(it.current == NULL);
    assert(it.next == NULL);

    XorLinkedList_free(list);
}

void test_before()
{
    List *list = XorLinkedList_new();
    Iterator it = XorLinkedList_iterator(list);

    Node *node1 = XorLinkedList_insert_before(&it, 1);
    assert(node1 != NULL);
    assert(node1->value == 1);
    assert(it.prev == node1);
    assert(it.current == NULL);
    assert(it.next == NULL);

    Node *node3 = XorLinkedList_insert_before(&it, 3);
    assert(node3 != NULL);
    assert(node3->value == 3);
    assert(it.prev == node3);
    assert(it.current == NULL);
    assert(it.next == NULL);

    XorLinkedList_prev(&it);

    Node *node2 = XorLinkedList_insert_before(&it, 2);
    assert(node2 != NULL);
    assert(node2->value == 2);
    assert(it.prev == node2);
    assert(it.current == node3);
    assert(it.next == NULL);

    it = XorLinkedList_iterator(list);
    assert(it.current == node1);
    XorLinkedList_next(&it);
    assert(it.current == node2);
    XorLinkedList_next(&it);
    assert(it.current == node3);
    XorLinkedList_next(&it);
    assert(it.current == NULL);

    XorLinkedList_free(list);
}

void test_after()
{
    List *list = XorLinkedList_new();
    Iterator it = XorLinkedList_iterator(list);

    Node *node3 = XorLinkedList_insert_after(&it, 3);
    assert(node3 != NULL);
    assert(node3->value == 3);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == node3);

    Node *node1 = XorLinkedList_insert_after(&it, 1);
    assert(node1 != NULL);
    assert(node1->value == 1);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == node1);

    XorLinkedList_next(&it);

    Node *node2 = XorLinkedList_insert_after(&it, 2);
    assert(node2 != NULL);
    assert(node2->value == 2);
    assert(it.prev == NULL);
    assert(it.current == node1);
    assert(it.next == node2);

    it = XorLinkedList_iterator(list);
    assert(it.current == node1);
    XorLinkedList_next(&it);
    assert(it.current == node2);
    XorLinkedList_next(&it);
    assert(it.current == node3);
    XorLinkedList_next(&it);
    assert(it.current == NULL);

    XorLinkedList_free(list);
}

void test_delete()
{
    List *list = XorLinkedList_new();
    int deleted = 0;
    Iterator it = XorLinkedList_iterator(list);

    deleted = XorLinkedList_delete(&it);
    assert(!deleted);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == NULL);

    Node *node1 = XorLinkedList_insert_before(&it, 1);
    Node *node2 = XorLinkedList_insert_before(&it, 2);
    Node *node3 = XorLinkedList_insert_before(&it, 3);
    Node *node4 = XorLinkedList_insert_before(&it, 4);

    // NULL 1 2 3 4 *NULL* -> NULL 1 2 3 4 *NULL*
    deleted = XorLinkedList_delete(&it);
    assert(!deleted);
    assert(it.prev == node4);
    assert(it.current == NULL);
    assert(it.next == NULL);

    // NULL 1 2 3 4 *NULL* -> NULL 1 *2* 3 4 NULL
    XorLinkedList_prev(&it);
    XorLinkedList_prev(&it);
    XorLinkedList_prev(&it);
    assert(it.current == node2);

    // NULL 1 *2* 3 4 NULL -> NULL 1 *3* 4 NULL
    deleted = XorLinkedList_delete(&it);
    assert(deleted);
    assert(it.prev == node1);
    assert(it.current == node3);
    assert(it.next == node4);

    // NULL 1 *3* 4 NULL -> NULL *1* 3 4 NULL
    XorLinkedList_prev(&it);
    assert(it.current == node1);

    // NULL *1* 3 4 NULL -> NULL *3* 4 NULL
    deleted = XorLinkedList_delete(&it);
    assert(deleted);
    assert(it.prev == NULL);
    assert(it.current == node3);
    assert(it.next == node4);

    // NULL *3* 4 NULL -> NULL 3 *4* NULL
    XorLinkedList_next(&it);
    assert(it.current == node4);

    // NULL 3 *4* NULL -> NULL 3 *NULL*
    deleted = XorLinkedList_delete(&it);
    assert(deleted);
    assert(it.prev == node3);
    assert(it.current == NULL);
    assert(it.next == NULL);

    // NULL 3 *NULL* -> NULL *3* NULL
    XorLinkedList_prev(&it);
    assert(it.current == node3);

    // NULL *3* NULL -> *NULL*
    deleted = XorLinkedList_delete(&it);
    assert(deleted);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == NULL);

    XorLinkedList_free(list);
}

