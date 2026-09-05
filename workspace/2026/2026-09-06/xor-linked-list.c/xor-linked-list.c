#include "xor-linked-list.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define PRE_CONDITION(condition) \
    _pre_condition(#condition, condition)

static void _pre_condition(const char *label, int condition);
static Node *_xor(const Node *node1, const Node *node2);
static List *_new_list(void);
static Node *_new_node(int value, Node *previous, Node *next);
static void _clean(List *list);
static void _free(List *list);
static int _is_empty(const List *list);
static Iterator _begin(const List *list);
static Node *_previous(Iterator *it);
static Node *_next(Iterator *it);
static int _is_begin(const Iterator *it);
static int _is_end(const Iterator *it);
static int _is_rend(const Iterator *it);
static Node *_insert_before(Iterator *it, int value);
static Node *_pop(Iterator *it);

List *XorLinkedList_new(void)
{
    return _new_list();
}

List *XorLinkedList_from_array(const int *array, int n)
{
    PRE_CONDITION(array != NULL);
    PRE_CONDITION(n >= 0);

    List *list = NULL;

    if ((list = _new_list()) == NULL)
        goto FAILED;

    Iterator it = _begin(list);

    for (int i = 0; i < n; i++)
        if (_insert_before(&it, array[i]) == NULL)
            goto FAILED;

    return list;

FAILED:
    _free(list);
    return NULL;
}

void XorLinkedList_clean(List *list)
{
    PRE_CONDITION(list != NULL);

    _clean(list);
}

void XorLinkedList_free(List *list)
{
    _free(list);
}

int XorLinkedList_is_empty(const List *list)
{
    PRE_CONDITION(list != NULL);

    return _is_empty(list);
}

int XorLinkedList_equals(const List *list1, const List *list2)
{
    PRE_CONDITION(list1 != NULL);
    PRE_CONDITION(list2 != NULL);

    Iterator it1 = _begin(list1);
    Iterator it2 = _begin(list2);

    while (it1.current != NULL && it2.current != NULL)
    {
        if (it1.current->value != it2.current->value)
            return 0;

        _next(&it1);
        _next(&it2);
    }

    return it1.current == NULL && it2.current == NULL;
}

int XorLinkedList_length(const List *list)
{
    PRE_CONDITION(list != NULL);

    int length = 0;

    for (Iterator it = _begin(list); it.current != NULL; _next(&it))
        length++;

    return length;
}

void XorLinkedList_reverse(List *list)
{
    PRE_CONDITION(list != NULL);

    Iterator it = _begin(list);
    Node *new_head = NULL;

    while (it.current != NULL)
    {
        Node *node = _pop(&it);

        if (new_head != NULL)
            new_head->link = _xor(new_head->link, node);

        node->link = new_head;

        new_head = node;
    }

    list->head = new_head;
}

void XorLinkedList_print(const List *list)
{
    PRE_CONDITION(list != NULL);

    printf("XorLinkedList([");

    const char *separator = "";

    for (Iterator it = _begin(list); it.current != NULL; _next(&it))
    {
        printf("%s%d", separator, it.current->value);
        separator = ", ";
    }

    printf("])\n");
}

Iterator XorLinkedList_begin(const List *list)
{
    PRE_CONDITION(list != NULL);

    return _begin(list);
}

Node *XorLinkedList_previous(Iterator *it)
{
    PRE_CONDITION(it != NULL);

    return _previous(it);
}

Node *XorLinkedList_next(Iterator *it)
{
    PRE_CONDITION(it != NULL);

    return _next(it);
}

Node *XorLinkedList_insert_before(Iterator *it, int value)
{
    PRE_CONDITION(it != NULL);

    return _insert_before(it, value);
}

Node *XorLinkedList_insert_after(Iterator *it, int value)
{
    PRE_CONDITION(it != NULL);

    if (_is_end(it))
        return NULL;

    Node *node = NULL;

    if ((node = _new_node(value, it->current, it->next)) == NULL)
        return NULL;

    if (_is_empty(it->list) || _is_rend(it))
        it->list->head = node;

    if (it->current != NULL)
        it->current->link = _xor(_xor(it->current->link, it->next), node);

    if (it->next != NULL)
        it->next->link = _xor(_xor(it->next->link, it->current), node);

    *it = (Iterator) {
        .list     = it->list,
        .previous = it->previous,
        .current  = it->current,
        .next     = node,
    };

    return node;
}

int XorLinkedList_delete(Iterator *it)
{
    PRE_CONDITION(it != NULL);

    Node *node = _pop(it);

    if (node == NULL)
        return 0;

    free(node);
    return 1;
}

static void _pre_condition(const char *label, int condition)
{
    assert(label != NULL);

    if (!condition)
    {
        fprintf(stderr, "pre-condition violation: %s\n", label);
        exit(1);
    }
}

static Node *_xor(const Node *node1, const Node *node2)
{
    return (Node *) (((uintptr_t) node1) ^ ((uintptr_t) node2));
}

static List *_new_list(void)
{
    List *list = NULL;

    if ((list = malloc(sizeof(*list))) == NULL)
        return NULL;

    *list = (List) {
        .head = NULL,
    };

    return list;
}

static Node *_new_node(int value, Node *previous, Node *next)
{
    Node *node = NULL;

    if ((node = malloc(sizeof(*node))) == NULL)
        return NULL;

    *node = (Node) {
        .value = value,
        .link  = _xor(previous, next),
    };

    return node;
}

static void _clean(List *list)
{
    assert(list != NULL);

    Iterator it = _begin(list);

    while (it.current != NULL)
    {
        Node *node = it.current;
        _next(&it);
        free(node);
    }

    list->head = NULL;
}

static void _free(List *list)
{
    if (list == NULL)
        return;

    _clean(list);
    free(list);
}

static int _is_empty(const List *list)
{
    assert(list != NULL);

    return list->head == NULL;
}

static Iterator _begin(const List *list)
{
    assert(list != NULL);

    return (Iterator) {
        .list     = (List *) list,
        .previous = NULL,
        .current  = list->head,
        .next     = list->head == NULL ? NULL : list->head->link,
    };
}

static Node *_previous(Iterator *it)
{
    assert(it != NULL);

    if (_is_rend(it))
        return NULL;

    *it = (Iterator) {
        .list     = it->list,
        .previous = it->previous == NULL ? NULL : _xor(it->previous->link, it->current),
        .current  = it->previous,
        .next     = it->current,
    };

    return it->current;
}

static Node *_next(Iterator *it)
{
    assert(it != NULL);

    if (_is_end(it))
        return NULL;

    *it = (Iterator) {
        .list     = it->list,
        .previous = it->current,
        .current  = it->next,
        .next     = it->next == NULL ? NULL : _xor(it->next->link, it->current),
    };

    return it->current;
}

static int _is_begin(const Iterator *it)
{
    assert(it != NULL);

    return it->list->head != NULL && it->list->head == it->current;
}

static int _is_end(const Iterator *it)
{
    assert(it != NULL);

    return it->previous != NULL && it->current == NULL && it->next == NULL;
}

static int _is_rend(const Iterator *it)
{
    assert(it != NULL);

    return it->previous == NULL && it->current == NULL && it->next != NULL;
}

static Node *_insert_before(Iterator *it, int value)
{
    assert(it != NULL);

    if (_is_rend(it))
        return NULL;

    Node *node = NULL;

    if ((node = _new_node(value, it->previous, it->current)) == NULL)
        return NULL;

    if (_is_empty(it->list) || _is_begin(it))
        it->list->head = node;

    if (it->previous != NULL)
        it->previous->link = _xor(_xor(it->previous->link, it->current), node);

    if (it->current != NULL)
        it->current->link = _xor(_xor(it->current->link, it->previous), node);

    *it = (Iterator) {
        .list     = it->list,
        .previous = node,
        .current  = it->current,
        .next     = it->next,
    };

    return node;
}

static Node *_pop(Iterator *it)
{
    assert(it != NULL);

    if (it->current == NULL)
        return NULL;

    Node *node = it->current;
    Node *new_next = it->next == NULL ? NULL : _xor(it->next->link, it->current);

    if (_is_begin(it))
        it->list->head = it->next;

    if (it->previous != NULL)
        it->previous->link = _xor(_xor(it->previous->link, it->current), it->next);

    if (it->next != NULL)
        it->next->link = _xor(_xor(it->next->link, it->current), it->previous);

    *it = (Iterator) {
        .list     = it->list,
        .previous = it->previous,
        .current  = it->next,
        .next     = new_next,
    };

    return node;
}

