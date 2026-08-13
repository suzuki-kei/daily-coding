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
static void _clear(List *list);
static Iterator _begin(List *list);
static Node *_prev(Iterator *it);
static Node *_next(Iterator *it);
static int _is_before_first(Iterator *it);
static int _is_after_last(Iterator *it);

List *XorLinkedList_new(void)
{
    return _new_list(NULL);
}

void XorLinkedList_free(List *list)
{
    if (list == NULL)
        return;

    _clear(list);
    free(list);
}

void XorLinkedList_clear(List *list)
{
    _PRE_CONDITION(list != NULL);

    _clear(list);
}

int XorLinkedList_length(List *list)
{
    _PRE_CONDITION(list != NULL);

    int length = 0;

    for (Iterator it = _begin(list); it.current != NULL; _next(&it))
        length++;

    return length;
}

void XorLinkedList_print(List *list)
{
    _PRE_CONDITION(list != NULL);

    printf("XorLinkedList([");

    const char *separator = "";

    for (Iterator it = _begin(list); it.current != NULL; _next(&it))
    {
        printf("%s%d", separator, it.current->value);
        separator = ", ";
    }

    printf("])\n");
}

Iterator XorLinkedList_begin(List *list)
{
    _PRE_CONDITION(list != NULL);

    return _begin(list);
}

Node *XorLinkedList_current(Iterator *it)
{
    _PRE_CONDITION(it != NULL);

    return it->current;
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

    if (it->prev == NULL)
        it->list->head = node;
    else
        it->prev->link = _xor(_xor(it->prev->link, it->current), node);

    if (it->current != NULL)
        it->current->link = _xor(node, it->next);

    it->prev = node;

    assert(it->list->head != NULL);
    assert(it->prev != NULL);

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

    if (it->current == NULL)
        it->list->head = node;

    if (it->current != NULL)
        it->current->link = _xor(it->prev, node);

    if (it->next != NULL)
        it->next->link = _xor(_xor(it->next->link, it->current), node);

    it->next = node;

    assert(it->list->head != NULL);
    assert(it->next != NULL);

    return node;
}

int XorLinkedList_delete(Iterator *it)
{
    _PRE_CONDITION(it != NULL);

    if (it->current == NULL)
        return 0;

    Node *current = it->current;
    Node *new_next = it->next == NULL ? NULL : _xor(it->next->link, it->current);

    if (it->current == it->list->head)
        it->list->head = it->next;

    if (it->prev != NULL)
        it->prev->link = _xor(_xor(it->prev->link, it->current), it->next);

    if (it->next != NULL)
        it->next->link = _xor(_xor(it->next->link, it->current), it->prev);

    *it = (Iterator) {
        .list    = it->list,
        .prev    = it->prev,
        .current = it->next,
        .next    = new_next,
    };

    free(current);

    return 1;
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

static void _clear(List *list)
{
    assert(list != NULL);

    for (Iterator it = _begin(list); it.current != NULL; )
    {
        Node *node = it.current;
        _next(&it);
        free(node);
    }

    list->head = NULL;
}

static Iterator _begin(List *list)
{
    assert(list != NULL);

    return (Iterator) {
        .list    = list,
        .prev    = NULL,
        .current = list->head,
        .next    = list->head == NULL ? NULL : _xor(list->head->link, NULL),
    };
}

static Node *_prev(Iterator *it)
{
    assert(it != NULL);

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

static Node *_next(Iterator *it)
{
    assert(it != NULL);

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

static int _is_before_first(Iterator *it)
{
    return it->prev == NULL && it->current == NULL && it->next != NULL;
}

static int _is_after_last(Iterator *it)
{
    return it->prev != NULL && it->current == NULL && it->next == NULL;
}

