#include "xor-linked-list.h"
#include <assert.h>
#include <stdio.h>

#define TEST(test_case) \
    {                                       \
        printf("==== %s\n", #test_case);    \
        test_case();                        \
    }

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

#define FROM_ARRAY(array) \
    XorLinkedList_from_array(array, ARRAY_LENGTH(array))

void test_new(void);
void test_from_array(void);
void test_free(void);
void test_clear(void);
void test_equals(void);
void test_length(void);
void test_print(void);
void test_begin(void);
void test_begin__null(void);
void test_begin__null_a(void);
void test_begin__null_a_b(void);
void test_begin__null_a_b_c(void);
void test_rbegin(void);
void test_rbegin__null(void);
void test_rbegin__null_a(void);
void test_rbegin__null_a_b(void);
void test_rbegin__null_a_b_c(void);
void test_end(void);
void test_rend(void);
void test_next(void);
void test_next__NULL(void);
void test_next__NULL_a_b_c_null(void);
void test_next__null_A_b_c_null(void);
void test_next__null_a_B_c_null(void);
void test_next__null_a_b_C_null(void);
void test_next__null_a_b_c_NULL(void);
void test_current(void);
void test_current__NULL(void);
void test_current__NULL_a_b_c_null(void);
void test_current__null_A_b_c_null(void);
void test_current__null_a_B_c_null(void);
void test_current__null_a_b_C_null(void);
void test_current__null_a_b_c_NULL(void);
void test_prev(void);
void test_prev_NULL(void);
void test_prev_NULL_a_b_c_null(void);
void test_prev_null_A_b_c_null(void);
void test_prev_null_a_B_c_null(void);
void test_prev_null_a_b_C_null(void);
void test_prev_null_a_b_c_NULL(void);
void test_insert_before(void);
void test_insert_before__NULL(void);
void test_insert_before__NULL_a_b_c_null(void);
void test_insert_before__null_A_b_c_null(void);
void test_insert_before__null_a_B_c_null(void);
void test_insert_before__null_a_b_C_null(void);
void test_insert_before__null_a_b_c_NULL(void);
void test_insert_after(void);
void test_insert_after__NULL(void);
void test_insert_after__NULL_a_b_c_null(void);
void test_insert_after__null_A_b_c_null(void);
void test_insert_after__null_a_B_c_null(void);
void test_insert_after__null_a_b_C_null(void);
void test_insert_after__null_a_b_c_NULL(void);
void test_delete(void);
void test_delete__NULL(void);
void test_delete__NULL_a_b_c_null(void);
void test_delete__null_A_b_c_null(void);
void test_delete__null_a_B_c_null(void);
void test_delete__null_a_b_C_null(void);
void test_delete__null_a_b_c_NULL(void);

int main(void)
{
    TEST(test_new);
    TEST(test_from_array);
    TEST(test_free);
    TEST(test_clear);
    TEST(test_equals);
    TEST(test_length);
    TEST(test_print);
    TEST(test_begin);
    TEST(test_rbegin);
    TEST(test_end);
    TEST(test_rend);
    TEST(test_next);
    TEST(test_current);
    TEST(test_prev);
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
    {
        // Arrange
        const int array[] = { 1 };
        List *expected_list = XorLinkedList_new();

        // Act
        List *list = XorLinkedList_from_array(array, 0);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
    }

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
    }

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
    }

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
    }
}

void test_free(void)
{
    {
        // Arrange
        // => nothing

        // Act
        XorLinkedList_free(NULL);

        // Assert
        // => success if don't terminate abnomally
    }

    {
        const int array[] = { 1, 2, 3 };

        for (int n = 0; n < ARRAY_LENGTH(array); n++)
        {
            // Arrange
            List *list = XorLinkedList_from_array(array, n);

            // Act
            XorLinkedList_free(list);

            // Assert
            // => success if don't terminate abnomally
        }
    }
}

void test_clear(void)
{
    const int array[] = { 1, 2, 3 };

    for (int n = 0; n < ARRAY_LENGTH(array); n++)
    {
        // Arrange
        List *list = XorLinkedList_from_array(array, n);

        // Act
        XorLinkedList_clear(list);

        // Assert
        assert(list->head == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_equals(void)
{
    {
        // Arrange
        List *list1 = XorLinkedList_new();
        List *list2 = XorLinkedList_new();

        // Act
        int equals = XorLinkedList_equals(list1, list2);

        // Assert
        assert(equals);

        // Cleanup
        XorLinkedList_free(list1);
        XorLinkedList_free(list2);
    }

    {
        // Arrange
        List *list1 = FROM_ARRAY(((int[]) { 1 }));
        List *list2 = FROM_ARRAY(((int[]) { 1 }));

        // Act
        int equals = XorLinkedList_equals(list1, list2);

        // Assert
        assert(equals);

        // Cleanup
        XorLinkedList_free(list1);
        XorLinkedList_free(list2);
    }

    {
        // Arrange
        List *list1 = FROM_ARRAY(((int[]) { 1 }));
        List *list2 = FROM_ARRAY(((int[]) { 2 }));

        // Act
        int equals = XorLinkedList_equals(list1, list2);

        // Assert
        assert(!equals);

        // Cleanup
        XorLinkedList_free(list1);
        XorLinkedList_free(list2);
    }

    {
        // Arrange
        List *list1 = FROM_ARRAY(((int[]) { 1, 2 }));
        List *list2 = FROM_ARRAY(((int[]) { 1, 2 }));

        // Act
        int equals = XorLinkedList_equals(list1, list2);

        // Assert
        assert(equals);

        // Cleanup
        XorLinkedList_free(list1);
        XorLinkedList_free(list2);
    }

    {
        // Arrange
        List *list1 = FROM_ARRAY(((int[]) { 1, 2 }));
        List *list2 = FROM_ARRAY(((int[]) { 2, 1 }));

        // Act
        int equals = XorLinkedList_equals(list1, list2);

        // Assert
        assert(!equals);

        // Cleanup
        XorLinkedList_free(list1);
        XorLinkedList_free(list2);
    }

    {
        // Arrange
        List *list1 = FROM_ARRAY(((int[]) { 1 }));
        List *list2 = FROM_ARRAY(((int[]) { 1, 2 }));

        // Act
        int equals = XorLinkedList_equals(list1, list2);

        // Assert
        assert(!equals);

        // Cleanup
        XorLinkedList_free(list1);
        XorLinkedList_free(list2);
    }

    {
        // Arrange
        List *list1 = FROM_ARRAY(((int[]) { 1, 2 }));
        List *list2 = FROM_ARRAY(((int[]) { 1 }));

        // Act
        int equals = XorLinkedList_equals(list1, list2);

        // Assert
        assert(!equals);

        // Cleanup
        XorLinkedList_free(list1);
        XorLinkedList_free(list2);
    }

    {
        // Arrange
        List *list1 = FROM_ARRAY(((int[]) { 1, 2 }));
        List *list2 = FROM_ARRAY(((int[]) { 1, 3 }));

        // Act
        int equals = XorLinkedList_equals(list1, list2);

        // Assert
        assert(!equals);

        // Cleanup
        XorLinkedList_free(list1);
        XorLinkedList_free(list2);
    }
}

void test_length(void)
{
    const int array[] = { 1, 2, 3 };

    for (int n = 0; n < ARRAY_LENGTH(array); n++)
    {
        // Arrange
        List *list = XorLinkedList_from_array(array, n);

        // Act
        int length = XorLinkedList_length(list);

        // Assert
        assert(length == n);

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_print(void)
{
    const int array[] = { 1, 2, 3 };

    for (int n = 0; n <= ARRAY_LENGTH(array); n++)
    {
        // Arrange
        List *list = XorLinkedList_from_array(array, n);

        // Act
        XorLinkedList_print(list);

        // Assert
        // => success if don't terminate abnomally

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_begin(void)
{
    // XorLinkedList([NULL])
    test_begin__null();

    // XorLinkedList([NULL, 1, NULL])
    test_begin__null_a();

    // XorLinkedList([NULL, 1, 2, NULL])
    test_begin__null_a_b();

    // XorLinkedList([NULL, 1, 2, 3, NULL])
    test_begin__null_a_b_c();
}

void test_begin__null(void)
{
    // Arrange
    List *list = XorLinkedList_new();

    // Act
    Iterator it = XorLinkedList_begin(list);

    // Assert
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_begin__null_a(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 3 }));

    // Act
    Iterator it = XorLinkedList_begin(list);

    // Assert
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current != NULL);
    assert(it.current->value == 3);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_begin__null_a_b(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 2, 3 }));

    // Act
    Iterator it = XorLinkedList_begin(list);

    // Assert
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current != NULL);
    assert(it.current->value == 2);
    assert(it.next != NULL);
    assert(it.next->value == 3);

    // Cleanup
    XorLinkedList_free(list);
}

void test_begin__null_a_b_c(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

    // Act
    Iterator it = XorLinkedList_begin(list);

    // Assert
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current != NULL);
    assert(it.current->value == 1);
    assert(it.next != NULL);
    assert(it.next->value == 2);

    // Cleanup
    XorLinkedList_free(list);
}

void test_rbegin(void)
{
    // XorLinkedList([NULL])
    test_rbegin__null();

    // XorLinkedList([NULL, 1, NULL])
    test_rbegin__null_a();

    // XorLinkedList([NULL, 1, 2, NULL])
    test_rbegin__null_a_b();

    // XorLinkedList([NULL, 1, 2, 3, NULL])
    test_rbegin__null_a_b_c();
}

void test_rbegin__null(void)
{
    // Arrange
    List *list = XorLinkedList_new();

    // Act
    Iterator it = XorLinkedList_rbegin(list);

    // Assert
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_rbegin__null_a(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1 }));

    // Act
    Iterator it = XorLinkedList_rbegin(list);

    // Assert
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current != NULL);
    assert(it.current->value == 1);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_rbegin__null_a_b(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2 }));

    // Act
    Iterator it = XorLinkedList_rbegin(list);

    // Assert
    assert(it.list == list);
    assert(it.prev != NULL);
    assert(it.current != NULL);
    assert(it.current->value == 2);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_rbegin__null_a_b_c(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

    // Act
    Iterator it = XorLinkedList_rbegin(list);

    // Assert
    assert(it.list == list);
    assert(it.prev != NULL);
    assert(it.current != NULL);
    assert(it.current->value == 3);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_end(void)
{
    // XorLinkedList([])
    {
        // Arrange
        List *list = XorLinkedList_new();

        // Act
        Iterator it = XorLinkedList_end(list);

        // Assert
        assert(it.list == list);
        assert(it.prev == NULL);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1])
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1 }));

        // Act
        Iterator it = XorLinkedList_end(list);

        // Assert
        assert(it.list == list);
        assert(it.prev != NULL);
        assert(it.prev->value == 1);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1, 2])
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2 }));

        // Act
        Iterator it = XorLinkedList_end(list);

        // Assert
        assert(it.list == list);
        assert(it.prev != NULL);
        assert(it.prev->value == 2);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1, 2, 3])
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

        // Act
        Iterator it = XorLinkedList_end(list);

        // Assert
        assert(it.list == list);
        assert(it.prev != NULL);
        assert(it.prev->value == 3);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_rend(void)
{
    // XorLinkedList([])
    {
        // Arrange
        List *list = XorLinkedList_new();

        // Act
        Iterator it = XorLinkedList_rend(list);

        // Assert
        assert(it.list == list);
        assert(it.prev == NULL);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([3])
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 3 }));

        // Act
        Iterator it = XorLinkedList_rend(list);

        // Assert
        assert(it.list == list);
        assert(it.prev == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 3);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1, 2])
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 2, 3 }));

        // Act
        Iterator it = XorLinkedList_rend(list);

        // Assert
        assert(it.list == list);
        assert(it.prev == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 2);

        // Cleanup
        XorLinkedList_free(list);
    }

    // XorLinkedList([1, 2, 3])
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

        // Act
        Iterator it = XorLinkedList_rend(list);

        // Assert
        assert(it.list == list);
        assert(it.prev == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 1);

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_next(void)
{
    // [NULL] -> [NULL]
    test_next__NULL();

    // [NULL] 1 2 3 NULL -> NULL [1] 2 3 NULL
    test_next__NULL_a_b_c_null();

    // NULL [1] 2 3 NULL -> NULL 1 [2] 3 NULL
    test_next__null_A_b_c_null();

    // NULL 1 [2] 3 NULL -> NULL 1 2 [3] NULL
    test_next__null_a_B_c_null();

    // NULL 1 2 [3] NULL -> NULL 1 2 3 [NULL]
    test_next__null_a_b_C_null();

    // NULL 1 2 3 [NULL] -> NULL 1 2 3 [NULL]
    test_next__null_a_b_c_NULL();
}

void test_next__NULL(void)
{
    // Arrange
    List *list = XorLinkedList_new();
    Iterator it = XorLinkedList_begin(list);

    // Act
    Node *node = XorLinkedList_next(&it);

    // Assert
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_next__NULL_a_b_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_prev(&it);

    // Act
    Node *node = XorLinkedList_next(&it);

    // Assert
    assert(node != NULL);
    assert(node->value == 1);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current != NULL);
    assert(it.current->value == 1);
    assert(it.next != NULL);
    assert(it.next->value == 2);

    // Cleanup
    XorLinkedList_free(list);
}

void test_next__null_A_b_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);

    // Act
    Node *node = XorLinkedList_next(&it);

    // Assert
    assert(node != NULL);
    assert(node->value == 2);
    assert(it.list == list);
    assert(it.prev != NULL);
    assert(it.prev->value == 1);
    assert(it.current != NULL);
    assert(it.current->value == 2);
    assert(it.next != NULL);
    assert(it.next->value == 3);

    // Cleanup
    XorLinkedList_free(list);
}

void test_next__null_a_B_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);

    // Act
    Node *node = XorLinkedList_next(&it);

    // Assert
    assert(node != NULL);
    assert(node->value == 3);
    assert(it.list == list);
    assert(it.prev != NULL);
    assert(it.prev->value == 2);
    assert(it.current != NULL);
    assert(it.current->value == 3);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_next__null_a_b_C_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);

    // Act
    Node *node = XorLinkedList_next(&it);

    // Assert
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev != NULL);
    assert(it.prev->value == 3);
    assert(it.current == NULL);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_next__null_a_b_c_NULL(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);

    // Act
    Node *node = XorLinkedList_next(&it);

    // Assert
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev != NULL);
    assert(it.prev->value == 3);
    assert(it.current == NULL);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_current(void)
{
    test_current__NULL();
    test_current__NULL_a_b_c_null();
    test_current__null_A_b_c_null();
    test_current__null_a_B_c_null();
    test_current__null_a_b_C_null();
    test_current__null_a_b_c_NULL();
}

void test_current__NULL(void)
{
    // Arrange
    List *list = XorLinkedList_new();
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_prev(&it);

    // Act
    Node *node = XorLinkedList_current(&it);

    // Assert
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_current__NULL_a_b_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_prev(&it);

    // Act
    Node *node = XorLinkedList_current(&it);

    // Assert
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next != NULL);
    assert(it.next->value == 1);

    // Cleanup
    XorLinkedList_free(list);
}

void test_current__null_A_b_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);

    // Act
    Node *node = XorLinkedList_current(&it);

    // Assert
    assert(node != NULL);
    assert(node->value == 1);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current != NULL);
    assert(it.current->value == 1);
    assert(it.next != NULL);
    assert(it.next->value == 2);

    // Cleanup
    XorLinkedList_free(list);
}

void test_current__null_a_B_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);

    // Act
    Node *node = XorLinkedList_current(&it);

    // Assert
    assert(node != NULL);
    assert(node->value == 2);
    assert(it.list == list);
    assert(it.prev != NULL);
    assert(it.prev->value == 1);
    assert(it.current != NULL);
    assert(it.current->value == 2);
    assert(it.next != NULL);
    assert(it.next->value == 3);

    // Cleanup
    XorLinkedList_free(list);
}

void test_current__null_a_b_C_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);

    // Act
    Node *node = XorLinkedList_current(&it);

    // Assert
    assert(node != NULL);
    assert(node->value == 3);
    assert(it.list == list);
    assert(it.prev != NULL);
    assert(it.prev->value == 2);
    assert(it.current != NULL);
    assert(it.current->value == 3);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_current__null_a_b_c_NULL(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);

    // Act
    Node *node = XorLinkedList_current(&it);

    // Assert
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev != NULL);
    assert(it.prev->value == 3);
    assert(it.current == NULL);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_prev(void)
{
    // [NULL]
    test_prev_NULL();

    // [NULL] A B C NULL -> [NULL] A B C NULL
    test_prev_NULL_a_b_c_null();

    // NULL [A] B C NULL -> [NULL] A B C NULL
    test_prev_null_A_b_c_null();

    // NULL A [B] C NULL -> NULL [A] B C NULL
    test_prev_null_a_B_c_null();

    // NULL A B [C] NULL -> NULL A [B] C NULL
    test_prev_null_a_b_C_null();

    // NULL A B C [NULL] -> NULL A B [C] NULL
    test_prev_null_a_b_c_NULL();
}

void test_prev_NULL(void)
{
    // Arrange
    List *list = XorLinkedList_new();
    Iterator it = XorLinkedList_begin(list);

    // Act
    Node *node = XorLinkedList_prev(&it);

    // Assert
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_prev_NULL_a_b_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_prev(&it);

    // Act
    Node *node = XorLinkedList_prev(&it);

    // Assert
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next != NULL);
    assert(it.next->value == 1);

    // Cleanup
    XorLinkedList_free(list);
}

void test_prev_null_A_b_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);

    // Act
    Node *node = XorLinkedList_prev(&it);

    // Assert
    assert(node == NULL);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next != NULL);
    assert(it.next->value == 1);

    // Cleanup
    XorLinkedList_free(list);
}

void test_prev_null_a_B_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);

    // Act
    Node *node = XorLinkedList_prev(&it);

    // Assert
    assert(node != NULL);
    assert(node->value == 1);
    assert(it.list == list);
    assert(it.prev == NULL);
    assert(it.current != NULL);
    assert(it.current->value == 1);
    assert(it.next != NULL);
    assert(it.next->value == 2);

    // Cleanup
    XorLinkedList_free(list);
}

void test_prev_null_a_b_C_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);

    // Act
    Node *node = XorLinkedList_prev(&it);

    // Assert
    assert(node != NULL);
    assert(node->value == 2);
    assert(it.list == list);
    assert(it.prev != NULL);
    assert(it.prev->value == 1);
    assert(it.current != NULL);
    assert(it.current->value == 2);
    assert(it.next != NULL);
    assert(it.next->value == 3);

    // Cleanup
    XorLinkedList_free(list);
}

void test_prev_null_a_b_c_NULL(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);

    // Act
    Node *node = XorLinkedList_prev(&it);

    // Assert
    assert(node != NULL);
    assert(node->value == 3);
    assert(it.list == list);
    assert(it.prev != NULL);
    assert(it.prev->value == 2);
    assert(it.current != NULL);
    assert(it.current->value == 3);
    assert(it.next == NULL);

    // Cleanup
    XorLinkedList_free(list);
}

void test_insert_before(void)
{
    // [NULL] -> 0 [NULL]
    test_insert_before__NULL();

    // [NULL] 1 2 3 NULL -> [NULL] 1 2 3 NULL
    test_insert_before__NULL_a_b_c_null();

    // NULL [1] 2 3 NULL -> NULL 0 [1] 2 3 NULL
    test_insert_before__null_A_b_c_null();

    // NULL 1 [2] 3 NULL -> NULL 1 0 [2] 3 NULL
    test_insert_before__null_a_B_c_null();

    // NULL 1 2 [3] NULL -> NULL 1 2 0 [3] NULL
    test_insert_before__null_a_b_C_null();

    // NULL 1 2 3 [NULL] -> NULL 1 2 3 0 [NULL]
    test_insert_before__null_a_b_c_NULL();
}

void test_insert_before__NULL(void)
{
    // Arrange
    List *list = XorLinkedList_new();
    Iterator it = XorLinkedList_begin(list);
    List *expected_list = FROM_ARRAY(((int[]) { 0 }));

    // Act
    Node *node = XorLinkedList_insert_before(&it, 0);

    // Assert
    assert(node != NULL);
    assert(node->value == 0);
    assert(node->link == NULL);
    assert(it.prev == node);
    assert(it.current == NULL);
    assert(it.next == NULL);
    assert(list->head == node);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
    XorLinkedList_free(expected_list);
}

void test_insert_before__NULL_a_b_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_prev(&it);
    Iterator it_before_act = it;
    Node *head_before_act = list->head;
    List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

    // Act
    Node *node = XorLinkedList_insert_before(&it, 0);

    // Assert
    assert(node == NULL);
    assert(it.prev == node);
    assert(it.current == it_before_act.current);
    assert(it.next == it_before_act.next);
    assert(list->head == head_before_act);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
    XorLinkedList_free(expected_list);
}

void test_insert_before__null_A_b_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    Iterator it_before_act = it;
    List *expected_list = FROM_ARRAY(((int[]) { 0, 1, 2, 3 }));

    // Act
    Node *node = XorLinkedList_insert_before(&it, 0);

    // Assert
    assert(node != NULL);
    assert(node->value == 0);
    assert(it.prev == node);
    assert(it.current == it_before_act.current);
    assert(it.next == it_before_act.next);
    assert(list->head == node);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
    XorLinkedList_free(expected_list);
}

void test_insert_before__null_a_B_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    Iterator it_before_act = it;
    Node *head_before_act = list->head;
    List *expected_list = FROM_ARRAY(((int[]) { 1, 0, 2, 3 }));

    // Act
    Node *node = XorLinkedList_insert_before(&it, 0);

    // Assert
    assert(node != NULL);
    assert(node->value == 0);
    assert(it.prev == node);
    assert(it.current == it_before_act.current);
    assert(it.next == it_before_act.next);
    assert(list->head == head_before_act);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
    XorLinkedList_free(expected_list);
}

void test_insert_before__null_a_b_C_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);
    Iterator it_before_act = it;
    Node *head_before_act = list->head;
    List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 0, 3 }));

    // Act
    Node *node = XorLinkedList_insert_before(&it, 0);

    // Assert
    assert(node != NULL);
    assert(node->value == 0);
    assert(it.prev == node);
    assert(it.current == it_before_act.current);
    assert(it.next == it_before_act.next);
    assert(list->head == head_before_act);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
    XorLinkedList_free(expected_list);
}

void test_insert_before__null_a_b_c_NULL(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);
    Iterator it_before_act = it;
    Node *head_before_act = list->head;
    List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 3, 0 }));

    // Act
    Node *node = XorLinkedList_insert_before(&it, 0);

    // Assert
    assert(node != NULL);
    assert(node->value == 0);
    assert(it.prev == node);
    assert(it.current == it_before_act.current);
    assert(it.next == it_before_act.next);
    assert(list->head == head_before_act);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
    XorLinkedList_free(expected_list);
}

void test_insert_after(void)
{
    // [NULL] -> [NULL] 0
    test_insert_after__NULL();

    // [NULL] 1 2 3 NULL -> [NULL] 0 1 2 3 NULL
    test_insert_after__NULL_a_b_c_null();

    // NULL [1] 2 3 NULL -> NULL [1] 0 2 3 NULL
    test_insert_after__null_A_b_c_null();

    // NULL 1 [2] 3 NULL -> NULL 1 [2] 0 3 NULL
    test_insert_after__null_a_B_c_null();

    // NULL 1 2 [3] NULL -> NULL 1 2 [3] 0 NULL
    test_insert_after__null_a_b_C_null();

    // NULL 1 2 3 [NULL] -> NULL 1 2 3 [NULL]
    test_insert_after__null_a_b_c_NULL();
}

void test_insert_after__NULL(void)
{
    // Arrange
    List *list = XorLinkedList_new();
    Iterator it = XorLinkedList_begin(list);
    List *expected_list = FROM_ARRAY(((int[]) { 0 }));

    // Act
    Node *node = XorLinkedList_insert_after(&it, 0);

    // Assert
    assert(node != NULL);
    assert(node->value == 0);
    assert(node->link == NULL);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == node);
    assert(list->head == node);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
    XorLinkedList_free(expected_list);
}

void test_insert_after__NULL_a_b_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_prev(&it);
    Iterator it_before_act = it;
    List *expected_list = FROM_ARRAY(((int[]) { 0, 1, 2, 3 }));

    // Act
    Node *node = XorLinkedList_insert_after(&it, 0);

    // Assert
    assert(node != NULL);
    assert(node->value == 0);
    assert(it.prev == it_before_act.prev);
    assert(it.current == it_before_act.current);
    assert(it.next == node);
    assert(list->head == node);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
    XorLinkedList_free(expected_list);
}

void test_insert_after__null_A_b_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    Iterator it_before_act = it;
    Node *head_before_act = list->head;
    List *expected_list = FROM_ARRAY(((int[]) { 1, 0, 2, 3 }));

    // Act
    Node *node = XorLinkedList_insert_after(&it, 0);

    // Assert
    assert(node != NULL);
    assert(node->value == 0);
    assert(it.prev == it_before_act.prev);
    assert(it.current == it_before_act.current);
    assert(it.next == node);
    assert(list->head == head_before_act);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
    XorLinkedList_free(expected_list);
}

void test_insert_after__null_a_B_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    Iterator it_before_act = it;
    Node *head_before_act = list->head;
    List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 0, 3 }));

    // Act
    Node *node = XorLinkedList_insert_after(&it, 0);

    // Assert
    assert(node != NULL);
    assert(node->value == 0);
    assert(it.prev == it_before_act.prev);
    assert(it.current == it_before_act.current);
    assert(it.next == node);
    assert(list->head == head_before_act);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
    XorLinkedList_free(expected_list);
}

void test_insert_after__null_a_b_C_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);
    Iterator it_before_act = it;
    Node *head_before_act = list->head;
    List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 3, 0 }));

    // Act
    Node *node = XorLinkedList_insert_after(&it, 0);

    // Assert
    assert(node != NULL);
    assert(node->value == 0);
    assert(it.prev == it_before_act.prev);
    assert(it.current == it_before_act.current);
    assert(it.next == node);
    assert(list->head == head_before_act);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
    XorLinkedList_free(expected_list);
}

void test_insert_after__null_a_b_c_NULL(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);
    Iterator it_before_act = it;
    Node *head_before_act = list->head;
    List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

    // Act
    Node *node = XorLinkedList_insert_after(&it, 0);

    // Assert
    assert(node == NULL);
    assert(it.prev == it_before_act.prev);
    assert(it.current == it_before_act.current);
    assert(it.next == it_before_act.next);
    assert(list->head == head_before_act);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
    XorLinkedList_free(expected_list);
}

void test_delete(void)
{
    // [NULL] -> [NULL]
    test_delete__NULL();

    // [NULL] A B C NULL -> [NULL] A B C NULL
    test_delete__NULL_a_b_c_null();

    // NULL [A] B C NULL -> NULL [B] C NULL
    test_delete__null_A_b_c_null();

    // NULL A [B] C NULL -> NULL A [C] NULL
    test_delete__null_a_B_c_null();

    // NULL A B [C] NULL -> NULL A B [NULL]
    test_delete__null_a_b_C_null();

    // NULL A B C [NULL] -> NULL A B C [NULL]
    test_delete__null_a_b_c_NULL();
}

void test_delete__NULL(void)
{
    // Arrange
    List *list = XorLinkedList_new();
    Iterator it = XorLinkedList_begin(list);
    List *expected_list = XorLinkedList_new();

    // Act
    int deleted = XorLinkedList_delete(&it);

    // Assert
    assert(!deleted);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next == NULL);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
}

void test_delete__NULL_a_b_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_prev(&it);
    List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

    // Act
    int deleted = XorLinkedList_delete(&it);

    // Assert
    assert(!deleted);
    assert(it.prev == NULL);
    assert(it.current == NULL);
    assert(it.next != NULL);
    assert(it.next->value == 1);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
}

void test_delete__null_A_b_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    List *expected_list = FROM_ARRAY(((int[]) { 2, 3 }));

    // Act
    int deleted = XorLinkedList_delete(&it);

    // Assert
    assert(deleted);
    assert(it.prev == NULL);
    assert(it.current != NULL);
    assert(it.current->value == 2);
    assert(it.next != NULL);
    assert(it.next->value == 3);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
}

void test_delete__null_a_B_c_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    List *expected_list = FROM_ARRAY(((int[]) { 1, 3 }));

    // Act
    int deleted = XorLinkedList_delete(&it);

    // Assert
    assert(deleted);
    assert(it.prev != NULL);
    assert(it.prev->value == 1);
    assert(it.current != NULL);
    assert(it.current->value == 3);
    assert(it.next == NULL);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
}

void test_delete__null_a_b_C_null(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);
    List *expected_list = FROM_ARRAY(((int[]) { 1, 2 }));

    // Act
    int deleted = XorLinkedList_delete(&it);

    // Assert
    assert(deleted);
    assert(it.prev != NULL);
    assert(it.prev->value == 2);
    assert(it.current == NULL);
    assert(it.next == NULL);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
}

void test_delete__null_a_b_c_NULL(void)
{
    // Arrange
    List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
    Iterator it = XorLinkedList_begin(list);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);
    XorLinkedList_next(&it);
    List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

    // Act
    int deleted = XorLinkedList_delete(&it);

    // Assert
    assert(!deleted);
    assert(it.prev != NULL);
    assert(it.prev->value == 3);
    assert(it.current == NULL);
    assert(it.next == NULL);
    assert(XorLinkedList_equals(list, expected_list));

    // Cleanup
    XorLinkedList_free(list);
}

