#include "xor-linked-list.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define _PRE_CONDITION(condition) \
    _pre_condition(#condition, condition)

static void _pre_condition(const char *label, int condition);
static Node *_xor(Node *p1, Node *p2);
static List *_new_list(Node *head);
static Node *_new_node(int value, Node *prev, Node *next);
static Iterator _iterator(List *list);
static Node *_prev(Iterator *it);
static Node *_next(Iterator *it);
static int _is_before_first(const Iterator *it);
static int _is_after_last(const Iterator *it);

List *XorLinkedList_new(void)
{
    return _new_list(NULL);
}

void XorLinkedList_free(List *list)
{
    if (list == NULL)
        return;

    Iterator it = _iterator(list);

    while (it.current != NULL)
    {
        Node *node = it.current;
        _next(&it);
        free(node);
    }

    free(list);
}

void XorLinkedList_print(List *list)
{
    _PRE_CONDITION(list != NULL);

    printf("XorLinkedList([");

    const char *separator = "";

    for (Iterator it = _iterator(list); it.current != NULL; _next(&it))
    {
        printf("%s%d", separator, it.current->value);
        separator = ", ";
    }

    printf("])\n");
}

Iterator XorLinkedList_iterator(List *list)
{
    _PRE_CONDITION(list != NULL);

    return _iterator(list);
}

Node *XorLinkedList_prev(Iterator *it)
{
    _PRE_CONDITION(it != NULL);

    return _prev(it);
}

Node *XorLinkedList_next(Iterator *it)
{
    _PRE_CONDITION(it != NULL);

    return _next(it);
}

Node *XorLinkedList_insert_before(Iterator *it, int value)
{
    _PRE_CONDITION(it != NULL);

    if (_is_before_first(it))
        return NULL;

    Node *node = NULL;

    if ((node = _new_node(value, it->prev, it->current)) == NULL)
        return NULL;

    if (it->list->head == it->current)
        it->list->head = node;

    if (it->prev != NULL)
        it->prev->link = _xor(_xor(it->prev->link, it->current), node);

    if (it->current != NULL)
        it->current->link = _xor(_xor(it->current->link, it->prev), node);

    it->prev = node;

    return node;
}

Node *XorLinkedList_insert_after(Iterator *it, int value)
{
    _PRE_CONDITION(it != NULL);

    if (_is_after_last(it))
        return NULL;

    Node *node = NULL;

    if ((node = _new_node(value, it->current, it->next)) == NULL)
        return NULL;

    if (it->list->head == NULL || _is_before_first(it))
        it->list->head = node;

    if (it->current != NULL)
        it->current->link = _xor(_xor(it->current->link, it->next), node);

    if (it->next != NULL)
        it->next->link = _xor(_xor(it->next->link, it->current), node);

    it->next = node;

    return node;
}

int XorLinkedList_delete(Iterator *it)
{
    _PRE_CONDITION(it != NULL);

    if (it->current == NULL)
        return 0;

    Node *node = it->current;

    if (it->list->head == it->current)
        it->list->head = it->next;

    if (it->prev != NULL)
        it->prev->link = _xor(_xor(it->prev->link, it->current), it->next);

    if (it->next != NULL)
        it->next->link = _xor(_xor(it->next->link, it->current), it->prev);

    it->current = it->next;
    it->next = it->next == NULL ? NULL : _xor(it->next->link, it->prev);

    free(node);

    return 1;
}

void _pre_condition(const char *label, int condition)
{
    if (!condition)
    {
        fprintf(stderr, "pre-condition violation: %s\n", label);
        exit(1);
    }
}

Node *_xor(Node *p1, Node *p2)
{
    return (Node *)(((uintptr_t) p1) ^ ((uintptr_t) p2));
}

List *_new_list(Node *head)
{
    List *list = NULL;

    if ((list = malloc(sizeof(*list))) == NULL)
        return NULL;

    *list = (List) {
        .head = head,
    };

    return list;
}

Node *_new_node(int value, Node *prev, Node *next)
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

Iterator _iterator(List *list)
{
    assert(list != NULL);

    return (Iterator) {
        .list    = list,
        .prev    = NULL,
        .current = list->head,
        .next    = list->head == NULL ? NULL : _xor(list->head->link, NULL),
    };
}

Node *_prev(Iterator *it)
{
    assert(it != NULL);

    if (_is_before_first(it))
        return NULL;

    *it = (Iterator) {
        .list    = it->list,
        .prev    = it->prev == NULL ? NULL : _xor(it->prev->link, it->current),
        .current = it->prev,
        .next    = it->current,
    };

    return it->current;
}

Node *_next(Iterator *it)
{
    assert(it != NULL);

    if (_is_after_last(it))
        return NULL;

    *it = (Iterator) {
        .list    = it->list,
        .prev    = it->current,
        .current = it->next,
        .next    = it->next == NULL ? NULL : _xor(it->next->link, it->current),
    };

    return it->current;
}

int _is_before_first(const Iterator *it)
{
    assert(it != NULL);

    return it->prev == NULL && it->current == NULL && it->next != NULL;
}

int _is_after_last(const Iterator *it)
{
    assert(it != NULL);

    return it->prev != NULL && it->current == NULL && it->next == NULL;
}

