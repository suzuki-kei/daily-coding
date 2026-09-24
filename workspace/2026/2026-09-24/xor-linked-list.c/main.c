#include "xor-linked-list.h"
#include <assert.h>
#include <stdio.h>

#define ARRAY_LENGTH(array) \
    (sizeof(array) / sizeof(*array))

#define FROM_ARRAY(array) \
    XorLinkedList_from_array((array), ARRAY_LENGTH((array)))

#define TEST(target) \
    {                                   \
        printf("==== %s\n", #target);   \
        target();                       \
    }

void test_new(void);
void test_from_list(void);
void test_from_array(void);
void test_free(void);
void test_clear(void);
void test_is_empty(void);
void test_equals(void);
void test_print(void);
void test_begin(void);
void test_rbegin(void);
void test_end(void);
void test_rend(void);
void test_previous(void);
void test_next(void);
void test_insert_before(void);
void test_insert_after(void);
void test_remove(void);

int main(void)
{
    TEST(test_new);
    TEST(test_from_list);
    TEST(test_from_array);
    TEST(test_free);
    TEST(test_clear);
    TEST(test_is_empty);
    TEST(test_equals);
    TEST(test_print);
    TEST(test_begin);
    TEST(test_rbegin);
    TEST(test_end);
    TEST(test_rend);
    TEST(test_previous);
    TEST(test_next);
    TEST(test_insert_before);
    TEST(test_insert_after);
    TEST(test_remove);
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

void test_from_list(void)
{
    // []
    {
        // Arrange
        List *list = XorLinkedList_new();
        List *expected_list = XorLinkedList_new();

        // Act
        List *new_list = XorLinkedList_from_list(list);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));
        assert(XorLinkedList_equals(new_list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(new_list);
        XorLinkedList_free(expected_list);
    }

    // [1]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1 }));
        List *expected_list = FROM_ARRAY(((int[]) { 1 }));

        // Act
        List *new_list = XorLinkedList_from_list(list);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));
        assert(XorLinkedList_equals(new_list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(new_list);
        XorLinkedList_free(expected_list);
    }

    // [1, 2]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2 }));
        List *expected_list = FROM_ARRAY(((int[]) { 1, 2 }));

        // Act
        List *new_list = XorLinkedList_from_list(list);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));
        assert(XorLinkedList_equals(new_list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(new_list);
        XorLinkedList_free(expected_list);
    }

    // [1, 2, 3]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

        // Act
        List *new_list = XorLinkedList_from_list(list);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));
        assert(XorLinkedList_equals(new_list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(new_list);
        XorLinkedList_free(expected_list);
    }
}

void test_from_array(void)
{
    const int array[] = { 1, 2, 3 };

    // []
    {
        // Arrange
        List *expected_list = XorLinkedList_new();

        // Act
        List *list = XorLinkedList_from_array(array, 0);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // [1]
    {
        // Arrange
        List *expected_list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(expected_list);
        XorLinkedList_insert_before(&it, 1);

        // Act
        List *list = XorLinkedList_from_array(array, 1);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // [1, 2]
    {
        // Arrange
        List *expected_list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(expected_list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);

        // Act
        List *list = XorLinkedList_from_array(array, 2);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // [1, 2, 3]
    {
        // Arrange
        List *expected_list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(expected_list);
        XorLinkedList_insert_before(&it, 1);
        XorLinkedList_insert_before(&it, 2);
        XorLinkedList_insert_before(&it, 3);

        // Act
        List *list = XorLinkedList_from_array(array, 3);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }
}

void test_free(void)
{
    // List([])
    {
        // Arrange
        List *list = XorLinkedList_new();

        // Act
        XorLinkedList_free(list);

        // Assert
        // => 異常終了しなければ OK とする
    }

    // List([1])
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1 }));

        // Act
        XorLinkedList_free(list);

        // Assert
        // => 異常終了しなければ OK とする
    }

    // List([1, 2])
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2 }));

        // Act
        XorLinkedList_free(list);

        // Assert
        // => 異常終了しなければ OK とする
    }

    // List([1, 2, 3])
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

        // Act
        XorLinkedList_free(list);

        // Assert
        // => 異常終了しなければ OK とする
    }
}

void test_clear(void)
{
    // []
    {
        // Arrange
        List *list = XorLinkedList_new();
        List *expected_list = XorLinkedList_new();

        // Act
        XorLinkedList_clear(list);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // [1]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1 }));
        List *expected_list = XorLinkedList_new();

        // Act
        XorLinkedList_clear(list);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // [1, 2]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2 }));
        List *expected_list = XorLinkedList_new();

        // Act
        XorLinkedList_clear(list);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // [1, 2, 3]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        List *expected_list = XorLinkedList_new();

        // Act
        XorLinkedList_clear(list);

        // Assert
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }
}

void test_is_empty(void)
{
    // []
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

    // [1]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1 }));

        // Act
        int is_empty = XorLinkedList_is_empty(list);

        // Assert
        assert(!is_empty);

        // Cleanup
        XorLinkedList_free(list);
    }

    // [1, 2]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2 }));

        // Act
        int is_empty = XorLinkedList_is_empty(list);

        // Assert
        assert(!is_empty);

        // Cleanup
        XorLinkedList_free(list);
    }

    // [1, 2, 3]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

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
    List *lists[] = {
        XorLinkedList_new(),
        FROM_ARRAY(((int[]) { 1 })),
        FROM_ARRAY(((int[]) { 2 })),
        FROM_ARRAY(((int[]) { 1, 2 })),
        FROM_ARRAY(((int[]) { 1, 3 })),
        FROM_ARRAY(((int[]) { 2, 1 })),
        FROM_ARRAY(((int[]) { 1, 2, 3 })),
    };

    for (int i = 0; i < ARRAY_LENGTH(lists); i++)
        for (int j = 0; j < ARRAY_LENGTH(lists); j++)
            if (i == j)
                assert(XorLinkedList_equals(lists[i], lists[j]));
            else
                assert(!XorLinkedList_equals(lists[i], lists[j]));
}

void test_print(void)
{
    // []
    {
        // Arrange
        List *list = XorLinkedList_new();

        // Act
        XorLinkedList_print(list);

        // Assert
        // => 異常終了しなければ OK とする

        // Cleanup
        XorLinkedList_free(list);
    }

    // [1]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1 }));

        // Act
        XorLinkedList_print(list);

        // Assert
        // => 異常終了しなければ OK とする

        // Cleanup
        XorLinkedList_free(list);
    }

    // [1, 2]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2 }));

        // Act
        XorLinkedList_print(list);

        // Assert
        // => 異常終了しなければ OK とする

        // Cleanup
        XorLinkedList_free(list);
    }

    // [1, 2, 3]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

        // Act
        XorLinkedList_print(list);

        // Assert
        // => 異常終了しなければ OK とする

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_begin(void)
{
    // []
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

    // [1]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1 }));

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

    // [2, 1]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 2, 1 }));

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

    // [3, 2, 1]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 3, 2, 1 }));

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

void test_rbegin(void)
{
    // []
    {
        // Arrange
        List *list = XorLinkedList_new();

        // Act
        Iterator it = XorLinkedList_rbegin(list);

        // Assert
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // [1]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1 }));

        // Act
        Iterator it = XorLinkedList_rbegin(list);

        // Assert
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current != NULL);
        assert(it.current->value == 1);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // [1, 2]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2 }));

        // Act
        Iterator it = XorLinkedList_rbegin(list);

        // Assert
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 1);
        assert(it.current != NULL);
        assert(it.current->value == 2);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // [1, 2, 3]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

        // Act
        Iterator it = XorLinkedList_rbegin(list);

        // Assert
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

void test_end(void)
{
    // []
    {
        // Arrange
        List *list = XorLinkedList_new();

        // Act
        Iterator it = XorLinkedList_end(list);

        // Assert
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // [1]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1 }));

        // Act
        Iterator it = XorLinkedList_end(list);

        // Assert
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 1);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // [1, 2]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2 }));

        // Act
        Iterator it = XorLinkedList_end(list);

        // Assert
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 2);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // [1, 2, 3]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

        // Act
        Iterator it = XorLinkedList_end(list);

        // Assert
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 3);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }
}

void test_rend(void)
{
    // []
    {
        // Arrange
        List *list = XorLinkedList_new();

        // Act
        Iterator it = XorLinkedList_rend(list);

        // Assert
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
    }

    // [1]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1 }));

        // Act
        Iterator it = XorLinkedList_rend(list);

        // Assert
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 1);

        // Cleanup
        XorLinkedList_free(list);
    }

    // [2, 1]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 2, 1 }));

        // Act
        Iterator it = XorLinkedList_rend(list);

        // Assert
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 2);

        // Cleanup
        XorLinkedList_free(list);
    }

    // [3, 2, 1]
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 3, 2, 1 }));

        // Act
        Iterator it = XorLinkedList_rend(list);

        // Assert
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 3);

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
        Iterator it = XorLinkedList_rend(list);

        // Act
        const Node *node = XorLinkedList_previous(&it);

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
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_rend(list);

        // Act
        const Node *node = XorLinkedList_previous(&it);

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
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_rend(list);
        XorLinkedList_next(&it);

        // Act
        const Node *node = XorLinkedList_previous(&it);

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
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_rend(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);

        // Act
        const Node *node = XorLinkedList_previous(&it);

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
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_rend(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);

        // Act
        const Node *node = XorLinkedList_previous(&it);

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
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_rend(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);

        // Act
        const Node *node = XorLinkedList_previous(&it);

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
        Iterator it = XorLinkedList_end(list);

        // Act
        const Node *node = XorLinkedList_next(&it);

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
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_end(list);
        XorLinkedList_previous(&it);
        XorLinkedList_previous(&it);
        XorLinkedList_previous(&it);
        XorLinkedList_previous(&it);

        // Act
        const Node *node = XorLinkedList_next(&it);

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
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_end(list);
        XorLinkedList_previous(&it);
        XorLinkedList_previous(&it);
        XorLinkedList_previous(&it);

        // Act
        const Node *node = XorLinkedList_next(&it);

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
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_end(list);
        XorLinkedList_previous(&it);
        XorLinkedList_previous(&it);

        // Act
        const Node *node = XorLinkedList_next(&it);

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
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_end(list);
        XorLinkedList_previous(&it);

        // Act
        const Node *node = XorLinkedList_next(&it);

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
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_end(list);

        // Act
        const Node *node = XorLinkedList_next(&it);

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
    // *NULL* -> 1 *NULL*
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        List *expected_list = FROM_ARRAY(((int[]) { 1 }));

        // Act
        int success = XorLinkedList_insert_before(&it, 1);

        // Assert
        assert(success);
        assert(XorLinkedList_equals(list, expected_list));
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 1);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // *NULL* 1 2 3 NULL -> *NULL* 1 2 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_previous(&it);
        List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

        // Act
        int success = XorLinkedList_insert_before(&it, 0);

        // Assert
        assert(!success);
        assert(XorLinkedList_equals(list, expected_list));
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 1);

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // NULL *1* 2 3 NULL -> NULL 0 *1* 2 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        List *expected_list = FROM_ARRAY(((int[]) { 0, 1, 2, 3 }));

        // Act
        int success = XorLinkedList_insert_before(&it, 0);

        // Assert
        assert(success);
        assert(XorLinkedList_equals(list, expected_list));
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 0);
        assert(it.current != NULL);
        assert(it.current->value == 1);
        assert(it.next != NULL);
        assert(it.next->value == 2);

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // NULL 1 *2* 3 NULL -> NULL 1 0 *2* 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);
        List *expected_list = FROM_ARRAY(((int[]) { 1, 0, 2, 3 }));

        // Act
        int success = XorLinkedList_insert_before(&it, 0);

        // Assert
        assert(success);
        assert(XorLinkedList_equals(list, expected_list));
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 0);
        assert(it.current != NULL);
        assert(it.current->value == 2);
        assert(it.next != NULL);
        assert(it.next->value == 3);

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // NULL 1 2 *3* NULL -> NULL 1 2 0 *3* NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 0, 3 }));

        // Act
        int success = XorLinkedList_insert_before(&it, 0);

        // Assert
        assert(success);
        assert(XorLinkedList_equals(list, expected_list));
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 0);
        assert(it.current != NULL);
        assert(it.current->value == 3);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // NULL 1 2 3 *NULL* -> NULL 1 2 3 0 *NULL*
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 3, 0 }));

        // Act
        int success = XorLinkedList_insert_before(&it, 0);

        // Assert
        assert(success);
        assert(XorLinkedList_equals(list, expected_list));
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 0);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }
}

void test_insert_after(void)
{
    // *NULL* -> *NULL* 0
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        List *expected_list = FROM_ARRAY(((int[]) { 0 }));

        // Act
        int success = XorLinkedList_insert_after(&it, 0);

        // Assert
        assert(success);
        assert(XorLinkedList_equals(list, expected_list));
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 0);

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // *NULL* 1 2 3 NULL -> *NULL* 0 1 2 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_previous(&it);
        List *expected_list = FROM_ARRAY(((int[]) { 0, 1, 2, 3 }));

        // Act
        int success = XorLinkedList_insert_after(&it, 0);

        // Assert
        assert(success);
        assert(XorLinkedList_equals(list, expected_list));
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 0);

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // NULL *1* 2 3 NULL -> NULL *1* 0 2 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        List *expected_list = FROM_ARRAY(((int[]) { 1, 0, 2, 3 }));

        // Act
        int success = XorLinkedList_insert_after(&it, 0);

        // Assert
        assert(success);
        assert(XorLinkedList_equals(list, expected_list));
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current != NULL);
        assert(it.current->value == 1);
        assert(it.next != NULL);
        assert(it.next->value == 0);

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // NULL 1 *2* 3 NULL -> NULL 1 *2* 0 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);
        List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 0, 3 }));

        // Act
        int success = XorLinkedList_insert_after(&it, 0);

        // Assert
        assert(success);
        assert(XorLinkedList_equals(list, expected_list));
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 1);
        assert(it.current != NULL);
        assert(it.current->value == 2);
        assert(it.next != NULL);
        assert(it.next->value == 0);

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // NULL 1 2 *3* NULL -> NULL 1 2 *3* 0 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 3, 0 }));

        // Act
        int success = XorLinkedList_insert_after(&it, 0);

        // Assert
        assert(success);
        assert(XorLinkedList_equals(list, expected_list));
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 2);
        assert(it.current != NULL);
        assert(it.current->value == 3);
        assert(it.next != NULL);
        assert(it.next->value == 0);

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }

    // NULL 1 2 3 *NULL* -> NULL 1 2 3 *NULL*
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_begin(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

        // Act
        int success = XorLinkedList_insert_after(&it, 0);

        // Assert
        assert(!success);
        assert(XorLinkedList_equals(list, expected_list));
        assert(it.list == list);
        assert(it.previous != NULL);
        assert(it.previous->value == 3);
        assert(it.current == NULL);
        assert(it.next == NULL);

        // Cleanup
        XorLinkedList_free(list);
        XorLinkedList_free(expected_list);
    }
}

void test_remove(void)
{
    // *NULL* -> *NULL*
    {
        // Arrange
        List *list = XorLinkedList_new();
        Iterator it = XorLinkedList_begin(list);
        List *expected_list = XorLinkedList_new();

        // Act
        int removed = XorLinkedList_remove(&it);

        // Assert
        assert(!removed);
        assert(it.list == list);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next == NULL);
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
    }

    // *NULL* 1 2 3 NULL -> *NULL* 1 2 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_rend(list);
        List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

        // Act
        int removed = XorLinkedList_remove(&it);

        // Assert
        assert(!removed);
        assert(it.previous == NULL);
        assert(it.current == NULL);
        assert(it.next != NULL);
        assert(it.next->value == 1);
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL *1* 2 3 NULL -> NULL *2* 3 NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_rend(list);
        XorLinkedList_next(&it);
        List *expected_list = FROM_ARRAY(((int[]) { 2, 3 }));

        // Act
        int removed = XorLinkedList_remove(&it);

        // Assert
        assert(removed);
        assert(it.previous == NULL);
        assert(it.current != NULL);
        assert(it.current->value == 2);
        assert(it.next != NULL);
        assert(it.next->value == 3);
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 *2* 3 NULL -> NULL 1 *3* NULL
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_rend(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        List *expected_list = FROM_ARRAY(((int[]) { 1, 3 }));

        // Act
        int removed = XorLinkedList_remove(&it);

        // Assert
        assert(removed);
        assert(it.previous != NULL);
        assert(it.previous->value == 1);
        assert(it.current != NULL);
        assert(it.current->value == 3);
        assert(it.next == NULL);
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 2 *3* NULL -> NULL 1 2 *NULL*
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_rend(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        List *expected_list = FROM_ARRAY(((int[]) { 1, 2 }));

        // Act
        int removed = XorLinkedList_remove(&it);

        // Assert
        assert(removed);
        assert(it.previous != NULL);
        assert(it.previous->value == 2);
        assert(it.current == NULL);
        assert(it.next == NULL);
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
    }

    // NULL 1 2 3 *NULL* -> NULL 1 2 3 *NULL*
    {
        // Arrange
        List *list = FROM_ARRAY(((int[]) { 1, 2, 3 }));
        Iterator it = XorLinkedList_rend(list);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        XorLinkedList_next(&it);
        List *expected_list = FROM_ARRAY(((int[]) { 1, 2, 3 }));

        // Act
        int removed = XorLinkedList_remove(&it);

        // Assert
        assert(!removed);
        assert(it.previous != NULL);
        assert(it.previous->value == 3);
        assert(it.current == NULL);
        assert(it.next == NULL);
        assert(XorLinkedList_equals(list, expected_list));

        // Cleanup
        XorLinkedList_free(list);
    }
}

