#include "xor-linked-list.h"
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define _PRE_CONDITION(condition) \
    _pre_condition(#condition, condition)

static void _pre_condition(const char *label, int condition);
static Node *_xor(Node *p1, Node *p2);
static List *_new_list(Node *head);
static Node *_new_node(int value, Node *prev, Node *next);

List *XorLinkedList_new(void)
{
    return _new_list(NULL);
}

void XorLinkedList_free(List *list)
{
    if (list == NULL)
        return;

    Node *node = NULL;
    Iterator it = XorLinkedList_begin(list);

    while ((node = XorLinkedList_current(&it)) != NULL)
    {
        XorLinkedList_next(&it);
        free(node);
    }

    free(list);
}

void XorLinkedList_print(List *list)
{
    _PRE_CONDITION(list != NULL);

    printf("XorLinkedList([");

    const Node *node = NULL;
    const char *separator = "";
    Iterator it = XorLinkedList_begin(list);

    while ((node = XorLinkedList_current(&it)) != NULL)
    {
        printf("%s%d", separator, node->value);
        separator = ", ";
        XorLinkedList_next(&it);
    }

    printf("])\n");
}

Iterator XorLinkedList_begin(List *list)
{
    _PRE_CONDITION(list != NULL);

    return (Iterator) {
        .list    = list,
        .prev    = NULL,
        .current = list->head,
        .next    = list->head == NULL ? NULL : _xor(list->head->link, NULL),
    };
}

Node *XorLinkedList_current(Iterator *it)
{
    _PRE_CONDITION(it != NULL);
    _PRE_CONDITION(it->list != NULL);

    return it->current;
}

Node *XorLinkedList_prev(Iterator *it)
{
    _PRE_CONDITION(it != NULL);
    _PRE_CONDITION(it->list != NULL);

    if (it->prev == NULL && it->current == NULL)
        return NULL;

    *it = (Iterator) {
        .list    = it->list,
        .prev    = it->prev == NULL ? NULL : _xor(it->prev->link, it->current),
        .current = it->prev,
        .next    = it->current,
    };

    return it->current;
}

Node *XorLinkedList_next(Iterator *it)
{
    _PRE_CONDITION(it != NULL);
    _PRE_CONDITION(it->list != NULL);

    if (it->current == NULL && it->next == NULL)
        return NULL;

    *it = (Iterator) {
        .list    = it->list,
        .prev    = it->current,
        .current = it->next,
        .next    = it->next == NULL ? NULL : _xor(it->next->link, it->current),
    };

    return it->current;
}

/**
 *
 * Iterator が指す要素の手前に要素を挿入する.
 *
 * 挿入前後で it が指す要素は変化しない.
 *
 * @param it
 *     挿入位置の基準となる Iterator.
 *     it のひとつ手前に要素を挿入する.
 *
 * @return
 *     挿入した Node.
 *     it が先頭要素のひとつ手前に位置する場合は NULL.
 *
 */
Node *XorLinkedList_insert_before(Iterator *it, int value)
{
    _PRE_CONDITION(it != NULL);
    _PRE_CONDITION(it->list != NULL);

    if (it->prev == NULL && it->current == NULL && it->next != NULL)
        return NULL;

    Node *node = NULL;

    if ((node = _new_node(value, it->prev, it->current)) == NULL)
        return NULL;

    if (it->list->head == NULL || it->current == it->list->head)
        it->list->head = node;

    if (it->current != NULL)
        it->current->link = _xor(node, it->next);

    if (it->prev != NULL)
        it->prev->link = _xor(_xor(it->prev->link, it->current), node);

    it->prev = node;

    return node;
}

/**
 *
 * Iterator が指す要素の後ろに要素を挿入する.
 *
 * 挿入前後で it が指す要素は変化しない.
 *
 * @param it
 *     挿入位置の基準となる Iterator.
 *     it のひとつ後ろに要素を挿入する.
 *
 * @return
 *     挿入した Node.
 *     it が末尾要素のひとつ後ろに位置する場合は NULL.
 *
 */
Node *XorLinkedList_insert_after(Iterator *it, int value)
{
    _PRE_CONDITION(it != NULL);
    _PRE_CONDITION(it->list != NULL);

    if (it->prev != NULL && it->current == NULL && it->next == NULL)
        return NULL;

    Node *node = NULL;

    if ((node = _new_node(value, it->current, it->next)) == NULL)
        return NULL;

    if (it->list->head == NULL)
        it->list->head = node;

    if (it->current == NULL)
        it->list->head = node;
    else
        it->current->link = _xor(it->prev, node);

    if (it->next != NULL)
        it->next->link = _xor(_xor(it->next->link, it->current), node);

    it->next = node;

    return node;
}

static void _pre_condition(const char *label, int condition)
{
    if (!condition)
    {
        fprintf(stderr, "pre-condition violation: %s\n", label);
        exit(1);
    }
}

static Node *_xor(Node *p1, Node *p2)
{
    return (Node *)(((uintptr_t) p1) ^ ((uintptr_t) p2));
}

static List *_new_list(Node *head)
{
    List *list = NULL;

    if ((list = malloc(sizeof(*list))) == NULL)
        return NULL;

    *list = (List) {
        .head = head,
    };

    return list;
}

static Node *_new_node(int value, Node *prev, Node *next)
{
    Node *node = NULL;

    if ((node = malloc(sizeof(*node))) == NULL)
        return NULL;

    *node = (Node) {
        .value = value,
        .link  = _xor(prev, next),
    };

    return node;
}

