#include "xor-linked-list.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

#define FROM_ARRAY(array) \
    XorLinkedList_from_array((array), ARRAY_LENGTH(array))

#define TEST(test) \
    {                                   \
        printf("===== %s\n", #test);    \
        test();                         \
    }

void test_new(void);
void test_from_array(void);
void test_clean(void);
void test_free(void);
void test_is_empty(void);
void test_equals(void);
void test_length(void);
void test_reverse(void);
void test_print(void);
void test_begin(void);
void test_previous(void);
void test_next(void);
void test_insert_before(void);
void test_insert_after(void);
void test_delete(void);

int main(void)
{
    TEST(test_new);
    TEST(test_from_array);
    TEST(test_clean);
    TEST(test_free);
    TEST(test_is_empty);
    TEST(test_equals);
    TEST(test_length);
    TEST(test_reverse);
    TEST(test_begin);
    TEST(test_print);
    TEST(test_previous);
    TEST(test_next);
    TEST(test_insert_before);
    TEST(test_insert_after);
    TEST(test_delete);

    return 0;
}

void test_new(void)
{
    // Arrange
    // => nothing

    // Act
    List *list = XorLinkedList_new();

    // Assert
    assert(list != NULL);
    assert(list->head == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_from_array(void)
{
    // [1]
    {
        // Arrange
        const int array[] = { 1 };
        List *expected_list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(expected_list);
        XorLinkedList_insert_before(&it, 1);

        // Act
        List *list = XorLinkedList_from_array(array, ARRAY_LENGTH(array));

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // [1, 2]
    {
        // Arrange
        const int array[] = { 1, 2 };
        List *expected_list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(expected_list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);

        // Act
        List *list = XorLinkedList_from_array(array, ARRAY_LENGTH(array));

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // [1, 2, 3]
    {
        // Arrange
        const int array[] = { 1, 2, 3 };
        List *expected_list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(expected_list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);
        XorLinkedList_insert_before(&it, 3);

        // Act
        List *list = XorLinkedList_from_array(array, ARRAY_LENGTH(array));

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }
}

void test_clean(void)
{
    // XorLinkedList([])
    {
        // Arrange
        List *list = XorLinkedList_new();

        // Act
        XorLinkedList_clean(list);

        // Assert
        assert(list->head == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1])
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);

        // Act
        XorLinkedList_clean(list);

        // Assert
        assert(list->head == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1, 2])
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);

        // Act
        XorLinkedList_clean(list);

        // Assert
        assert(list->head == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1, 2, 3])
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);
        XorLinkedList_insert_before(&it, 3);

        // Act
        XorLinkedList_clean(list);

        // Assert
        assert(list->head == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_free(void)
{
    // XorLinkedList([])
    {
        // Arrange
        List *list = XorLinkedList_new();

        // Act
        XorLinkedList_free(list);

        // Assert
        // => 異常終了しなければ成功とする
    }

    // XorLinkedList([1])
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);

        // Act
        XorLinkedList_free(list);

        // Assert
        // => 異常終了しなければ成功とする
    }

    // XorLinkedList([1, 2])
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);

        // Act
        XorLinkedList_free(list);

        // Assert
        // => 異常終了しなければ成功とする
    }

    // XorLinkedList([1, 2, 3])
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);
        XorLinkedList_insert_before(&it, 3);

        // Act
        XorLinkedList_free(list);

        // Assert
        // => 異常終了しなければ成功とする
    }
}

void test_is_empty(void)
{
    // XorLinkedList([])
    {
        // Arrange
        List *list = XorLinkedList_new();

        // Act
        int is_empty = XorLinkedList_is_empty(list);

        // Assert
        assert(is_empty);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1])
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);

        // Act
        int is_empty = XorLinkedList_is_empty(list);

        // Assert
        assert(!is_empty);

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_equals(void)
{
    // equals([], [])
    {
        // Arrange
        List *list1 = XorLinkedList_new();
        List *list2 = XorLinkedList_new();

        // Act
        int equals1 = XorLinkedList_equals(list1, list2);
        int equals2 = XorLinkedList_equals(list2, list1);

        // Assert
        assert(equals1);
        assert(equals2);

        // Cleanup
        XorLinkedList_free(list1);
        XorLinkedList_free(list2);
    }

    // equals([1], [1])
    {
        // Arrange
        List *list1 = FROM_ARRAY(((int []) { 1 }));
        List *list2 = FROM_ARRAY(((int []) { 1 }));

        // Act
        int equals1 = XorLinkedList_equals(list1, list2);
        int equals2 = XorLinkedList_equals(list2, list1);

        // Assert
        assert(equals1);
        assert(equals2);

        // Cleanup
        XorLinkedList_free(list1);
        XorLinkedList_free(list2);
    }

    // equals([1], [2])
    {
        // Arrange
        List *list1 = FROM_ARRAY(((int []) { 1 }));
        List *list2 = FROM_ARRAY(((int []) { 2 }));

        // Act
        int equals1 = XorLinkedList_equals(list1, list2);
        int equals2 = XorLinkedList_equals(list2, list1);

        // Assert
        assert(!equals1);
        assert(!equals2);

        // Cleanup
        XorLinkedList_free(list1);
        XorLinkedList_free(list2);
    }

    // equals([1], [1, 2])
    {
        // Arrange
        List *list1 = FROM_ARRAY(((int []) { 1 }));
        List *list2 = FROM_ARRAY(((int []) { 1, 2 }));

        // Act
        int equals1 = XorLinkedList_equals(list1, list2);
        int equals2 = XorLinkedList_equals(list2, list1);

        // Assert
        assert(!equals1);
        assert(!equals2);

        // Cleanup
        XorLinkedList_free(list1);
        XorLinkedList_free(list2);
    }
}

void test_length(void)
{
    // XorLinkedList([])
    {
        // Arrange
        List *list = XorLinkedList_new();

        // Act
        int length = XorLinkedList_length(list);

        // Assert
        assert(length == 0);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1])
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);

        // Act
        int length = XorLinkedList_length(list);

        // Assert
        assert(length == 1);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1, 2])
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);

        // Act
        int length = XorLinkedList_length(list);

        // Assert
        assert(length == 2);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1, 2, 3])
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);
        XorLinkedList_insert_before(&it, 3);

        // Act
        int length = XorLinkedList_length(list);

        // Assert
        assert(length == 3);

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_reverse(void)
{
    // XorLinkedList([])
    {
        // Arrange
        List *list = XorLinkedList_new();
        List *expected_list = XorLinkedList_new();

        // Act
        XorLinkedList_reverse(list);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // XorLinkedList([1])
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1 }));
        List *expected_list = FROM_ARRAY(((int []) { 1 }));

        // Act
        XorLinkedList_reverse(list);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // XorLinkedList([1, 2])
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2 }));
        List *expected_list = FROM_ARRAY(((int []) { 2, 1 }));

        // Act
        XorLinkedList_reverse(list);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // XorLinkedList([1, 2, 3])
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        List *expected_list = FROM_ARRAY(((int []) { 3, 2, 1 }));

        // Act
        XorLinkedList_reverse(list);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }
}

void test_begin(void)
{
    // XorLinkedList([])
    {
        // Arrange
        List *list = XorLinkedList_new();

        // Act
        Iterator it = XorLinkedList_begin(list);

        // Assert
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1])
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1 }));

        // Act
        Iterator it = XorLinkedList_begin(list);

        // Assert
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current != NULL);
        assert(it.current->value == 1);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([2, 1])
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 2, 1 }));

        // Act
        Iterator it = XorLinkedList_begin(list);

        // Assert
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current != NULL);
        assert(it.current->value == 2);
        assert(it.next != NULL);
        assert(it.next->value == 1);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([3, 2, 1])
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 3, 2, 1 }));

        // Act
        Iterator it = XorLinkedList_begin(list);

        // Assert
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current != NULL);
        assert(it.current->value == 3);
        assert(it.next != NULL);
        assert(it.next->value == 2);

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_print(void)
{
    // XorLinkedList([])
    {
        // Arrange
        List *list = XorLinkedList_new();

        // Act
        XorLinkedList_print(list);

        // Assert
        // => 異常終了しなければ成功とする

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1])
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1 }));

        // Act
        XorLinkedList_print(list);

        // Assert
        // => 異常終了しなければ成功とする

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1, 2])
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2 }));

        // Act
        XorLinkedList_print(list);

        // Assert
        // => 異常終了しなければ成功とする

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1, 2, 3])
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));

        // Act
        XorLinkedList_print(list);

        // Assert
        // => 異常終了しなければ成功とする

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_previous(void)
{
    // *NULL* -> *NULL*
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);

        // Act
        Node *node = XorLinkedList_previous(&it);

        // Assert
        assert(node == NULL);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // *NULL* 1 2 3 NULL -> *NULL* 1 2 3 NULL
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_after(&it, 3);
        XorLinkedList_insert_after(&it, 2);
        XorLinkedList_insert_after(&it, 1);

        // Act
        Node *node = XorLinkedList_previous(&it);

        // Assert
        assert(node == NULL);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 1);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL *1* 2 3 NULL -> *NULL* 1 2 3 NULL
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_after(&it, 3);
        XorLinkedList_insert_after(&it, 2);
        XorLinkedList_insert_after(&it, 1);
        XorLinkedList_next(&it);

        // Act
        Node *node = XorLinkedList_previous(&it);

        // Assert
        assert(node == NULL);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 1);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 *2* 3 NULL -> NULL *1* 2 3 NULL
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_after(&it, 3);
        XorLinkedList_insert_after(&it, 2);
        XorLinkedList_insert_after(&it, 1);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);

        // Act
        Node *node = XorLinkedList_previous(&it);

        // Assert
        assert(node != NULL);
        assert(node->value == 1);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current != NULL);
        assert(it.current->value == 1);
        assert(it.next != NULL);
        assert(it.next->value == 2);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 2 *3* NULL -> NULL 1 *2* 3 NULL
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_after(&it, 3);
        XorLinkedList_insert_after(&it, 2);
        XorLinkedList_insert_after(&it, 1);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);

        // Act
        Node *node = XorLinkedList_previous(&it);

        // Assert
        assert(node != NULL);
        assert(node->value == 2);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 1);
        assert(it.current != NULL);
        assert(it.current->value == 2);
        assert(it.next != NULL);
        assert(it.next->value == 3);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 2 3 *NULL* -> NULL 1 2 *3* NULL
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_after(&it, 3);
        XorLinkedList_insert_after(&it, 2);
        XorLinkedList_insert_after(&it, 1);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);

        // Act
        Node *node = XorLinkedList_previous(&it);

        // Assert
        assert(node != NULL);
        assert(node->value == 3);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 2);
        assert(it.current != NULL);
        assert(it.current->value == 3);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_next(void)
{
    // *NULL* -> *NULL*
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);

        // Act
        Node *node = XorLinkedList_next(&it);

        // Assert
        assert(node == NULL);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // *NULL* 1 2 3 NULL -> NULL *1* 2 3 NULL
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);
        XorLinkedList_insert_before(&it, 3);
        XorLinkedList_previous(&it);
        XorLinkedList_previous(&it);
        XorLinkedList_previous(&it);
        XorLinkedList_previous(&it);

        // Act
        Node *node = XorLinkedList_next(&it);

        // Assert
        assert(node != NULL);
        assert(node->value == 1);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current != NULL);
        assert(it.current->value == 1);
        assert(it.next != NULL);
        assert(it.next->value == 2);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL *1* 2 3 NULL -> NULL 1 *2* 3 NULL
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);
        XorLinkedList_insert_before(&it, 3);
        XorLinkedList_previous(&it);
        XorLinkedList_previous(&it);
        XorLinkedList_previous(&it);

        // Act
        Node *node = XorLinkedList_next(&it);

        // Assert
        assert(node != NULL);
        assert(node->value == 2);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 1);
        assert(it.current != NULL);
        assert(it.current->value == 2);
        assert(it.next != NULL);
        assert(it.next->value == 3);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 *2* 3 NULL -> NULL 1 2 *3* NULL
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);
        XorLinkedList_insert_before(&it, 3);
        XorLinkedList_previous(&it);
        XorLinkedList_previous(&it);

        // Act
        Node *node = XorLinkedList_next(&it);

        // Assert
        assert(node != NULL);
        assert(node->value == 3);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 2);
        assert(it.current != NULL);
        assert(it.current->value == 3);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 2 *3* NULL -> NULL 1 2 3 *NULL*
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);
        XorLinkedList_insert_before(&it, 3);
        XorLinkedList_previous(&it);

        // Act
        Node *node = XorLinkedList_next(&it);

        // Assert
        assert(node == NULL);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 3);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 2 3 *NULL* -> NULL 1 2 3 *NULL*
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);
        XorLinkedList_insert_before(&it, 3);

        // Act
        Node *node = XorLinkedList_next(&it);

        // Assert
        assert(node == NULL);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 3);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_insert_before(void)
{
    // *NULL* -> 0 *NULL*
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);

        // Act
        Node *node = XorLinkedList_insert_before(&it, 0);

        // Assert
        assert(node != NULL);
        assert(node->value == 0);
        assert(node->link == NULL);
        assert(list->head == node);
        assert(it.list == list);
        assert(it.previous == node);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // *NULL* 1 2 3 NULL -> *NULL* 1 2 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_previous(&it);

        // Act
        Node *node = XorLinkedList_insert_before(&it, 0);

        // Assert
        assert(node == NULL);
        assert(list->head != NULL);
        assert(list->head->value == 1);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 1);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL *1* 2 3 NULL -> NULL 0 *1* 2 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);

        // Act
        Node *node = XorLinkedList_insert_before(&it, 0);

        // Assert
        assert(node != NULL);
        assert(node->value == 0);
        assert(list->head != NULL);
        assert(list->head->value == 0);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 0);
        assert(it.current != NULL);
        assert(it.current->value == 1);
        assert(it.next != NULL);
        assert(it.next->value == 2);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 *2* 3 NULL -> NULL 1 0 *2* 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);

        // Act
        Node *node = XorLinkedList_insert_before(&it, 0);

        // Assert
        assert(node != NULL);
        assert(node->value == 0);
        assert(list->head != NULL);
        assert(list->head->value == 1);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 0);
        assert(it.current != NULL);
        assert(it.current->value == 2);
        assert(it.next != NULL);
        assert(it.next->value == 3);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 2 *3* NULL -> NULL 1 2 0 *3* NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);

        // Act
        Node *node = XorLinkedList_insert_before(&it, 0);

        // Assert
        assert(node != NULL);
        assert(node->value == 0);
        assert(list->head != NULL);
        assert(list->head->value == 1);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 0);
        assert(it.current != NULL);
        assert(it.current->value == 3);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 2 3 *NULL* -> NULL 1 2 3 0 *NULL*
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);

        // Act
        Node *node = XorLinkedList_insert_before(&it, 0);

        // Assert
        assert(node != NULL);
        assert(node->value == 0);
        assert(list->head != NULL);
        assert(list->head->value == 1);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 0);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_insert_after(void)
{
    // *NULL* -> *NULL* 0
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);

        // Act
        Node *node = XorLinkedList_insert_after(&it, 0);

        // Assert
        assert(node != NULL);
        assert(node->value == 0);
        assert(list->head != NULL);
        assert(list->head->value == 0);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 0);

        // Cleanup
        XorLinkedList_free(list);
    }

    // *NULL* 1 2 3 NULL -> *NULL* 0 1 2 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_previous(&it);

        // Act
        Node *node = XorLinkedList_insert_after(&it, 0);

        // Assert
        assert(node != NULL);
        assert(node->value == 0);
        assert(list->head != NULL);
        assert(list->head->value == 0);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 0);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL *1* 2 3 NULL -> NULL *1* 0 2 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);

        // Act
        Node *node = XorLinkedList_insert_after(&it, 0);

        // Assert
        assert(node != NULL);
        assert(node->value == 0);
        assert(list->head != NULL);
        assert(list->head->value == 1);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current != NULL);
        assert(it.current->value == 1);
        assert(it.next != NULL);
        assert(it.next->value == 0);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 *2* 3 NULL -> NULL 1 *2* 0 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);

        // Act
        Node *node = XorLinkedList_insert_after(&it, 0);

        // Assert
        assert(node != NULL);
        assert(node->value == 0);
        assert(list->head != NULL);
        assert(list->head->value == 1);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 1);
        assert(it.current != NULL);
        assert(it.current->value == 2);
        assert(it.next != NULL);
        assert(it.next->value == 0);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 2 *3* NULL -> NULL 1 2 *3* 0 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);

        // Act
        Node *node = XorLinkedList_insert_after(&it, 0);

        // Assert
        assert(node != NULL);
        assert(node->value == 0);
        assert(list->head != NULL);
        assert(list->head->value == 1);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 2);
        assert(it.current != NULL);
        assert(it.current->value == 3);
        assert(it.next != NULL);
        assert(it.next->value == 0);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 2 3 *NULL* -> NULL 1 2 3 *NULL*
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);

        // Act
        Node *node = XorLinkedList_insert_after(&it, 0);

        // Assert
        assert(node == NULL);
        assert(list->head != NULL);
        assert(list->head->value == 1);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 3);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_delete(void)
{
    // NULL -> NULL
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);

        // Act
        int deleted = XorLinkedList_delete(&it);

        // Assert
        assert(!deleted);
        assert(list->head == NULL);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL *1* NULL -> NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1 }));
        Iterator it = XorLinkedList_begin(list);

        // Act
        int deleted = XorLinkedList_delete(&it);

        // Assert
        assert(deleted);
        assert(list->head == NULL);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // *NULL* 1 2 3 NULL -> NULL 1 2 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_previous(&it);

        // Act
        int deleted = XorLinkedList_delete(&it);

        // Assert
        assert(!deleted);
        assert(list->head != NULL);
        assert(list->head->value == 1);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 1);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL *1* 2 3 NULL -> NULL *2* 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);

        // Act
        int deleted = XorLinkedList_delete(&it);

        // Assert
        assert(deleted);
        assert(list->head != NULL);
        assert(list->head->value == 2);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current != NULL);
        assert(it.current->value == 2);
        assert(it.next != NULL);
        assert(it.next->value == 3);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 *2* 3 NULL -> NULL 1 *3* NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);

        // Act
        int deleted = XorLinkedList_delete(&it);

        // Assert
        assert(deleted);
        assert(list->head != NULL);
        assert(list->head->value == 1);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 1);
        assert(it.current != NULL);
        assert(it.current->value == 3);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 2 *3* NULL -> NULL 1 2 *NULL*
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);

        // Act
        int deleted = XorLinkedList_delete(&it);

        // Assert
        assert(deleted);
        assert(list->head != NULL);
        assert(list->head->value == 1);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 2);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 2 3 *NULL* -> NULL 1 2 3 *NULL*
    {
        // Arrange
        List *list = FROM_ARRAY(((int []) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);

        // Act
        int deleted = XorLinkedList_delete(&it);

        // Assert
        assert(!deleted);
        assert(list->head != NULL);
        assert(list->head->value == 1);
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 3);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }
}

