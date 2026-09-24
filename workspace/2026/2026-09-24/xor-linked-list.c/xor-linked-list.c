#include "xor-linked-list.h"
#include <assert.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

static void _pre_condition(const char *file, int line, const char *label, int condition);
static Node *_xor(Node *node1, Node *node2);
static List *_new_list(void);
static Node *_new_node(int value, Node *previous, Node *next);
static void _free(List *list);
static void _clear(List *list);
static Iterator _begin(const List *list);
static Iterator _rbegin(const List *list);
static Iterator _end(const List *list);
static Iterator _rend(const List *list);
static Node *_previous(Iterator *it);
static Node *_next(Iterator *it);
static int _insert_before(Iterator *it, int value);
static int _insert_after(Iterator *it, int value);
static int _is_empty(const List *list);
static int _is_begin(const Iterator *it);
//static int _is_rbegin(const Iterator *it);
static int _is_end(const Iterator *it);
static int _is_rend(const Iterator *it);

#define PRE_CONDITION(condition) \
    _pre_condition(__FILE__, __LINE__, #condition, condition)

List *XorLinkedList_new(void)
{
    return _new_list();
}

List *XorLinkedList_from_list(const List *list)
{
    PRE_CONDITION(list != NULL);

    List *new_list = NULL;

    if ((new_list = _new_list()) == NULL)
        goto FAILED;

    Iterator source = _begin(list);
    Iterator destination = _begin(new_list);

    while (source.current != NULL)
    {
        if (!_insert_before(&destination, source.current->value))
            goto FAILED;

        _next(&source);
    }

    return new_list;

FAILED:
    _free(new_list);
    return NULL;
}

List *XorLinkedList_from_array(const int *array, int n)
{
    PRE_CONDITION(array != NULL);

    List *list = NULL;

    if ((list = _new_list()) == NULL)
        return NULL;

    Iterator it = _begin(list);

    for (int i = 0; i < n; i++)
        if (!_insert_before(&it, array[i]))
            goto FAILED;

    return list;

FAILED:
    _free(list);
    return NULL;
}

void XorLinkedList_free(List *list)
{
    _free(list);
}

void XorLinkedList_clear(List *list)
{
    PRE_CONDITION(list != NULL);

    _clear(list);
}

int XorLinkedList_is_empty(const List *list)
{
    PRE_CONDITION(list != NULL);

    return list->head == NULL;
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

Iterator XorLinkedList_rbegin(const List *list)
{
    PRE_CONDITION(list != NULL);

    return _rbegin(list);
}

Iterator XorLinkedList_end(const List *list)
{
    PRE_CONDITION(list != NULL);

    return _end(list);
}

Iterator XorLinkedList_rend(const List *list)
{
    PRE_CONDITION(list != NULL);

    return _rend(list);
}

const Node *XorLinkedList_previous(Iterator *it)
{
    PRE_CONDITION(it != NULL);

    return _previous(it);
}

const Node *XorLinkedList_next(Iterator *it)
{
    PRE_CONDITION(it != NULL);

    return _next(it);
}

int XorLinkedList_insert_before(Iterator *it, int value)
{
    PRE_CONDITION(it != NULL);

    return _insert_before(it, value);
}

int XorLinkedList_insert_after(Iterator *it, int value)
{
    PRE_CONDITION(it != NULL);

    return _insert_after(it, value);
}

int XorLinkedList_remove(Iterator *it)
{
    PRE_CONDITION(it != NULL);

    if (it->current == NULL)
        return 0;

    Node *node = it->current;
    Node *new_next = it->next == NULL ? NULL : _xor(it->next->link, it->current);

    if (it->list->head == node)
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

    free(node);

    return 1;
}

static void _pre_condition(const char *file, int line, const char *label, int condition)
{
    if (!condition)
    {
        fprintf(stderr, "pre-condition violation: %s (file=%s, line=%d)\n", label, file, line);
        exit(1);
    }
}

static Node *_xor(Node *node1, Node *node2)
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

static void _free(List *list)
{
    if (list == NULL)
        return;

    _clear(list);
    free(list);
}

static void _clear(List *list)
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

static Iterator _begin(const List *list)
{
    assert(list != NULL);

    return (Iterator) {
        .list     = (List *) list,
        .previous = NULL,
        .current  = list->head,
        .next     = list->head == NULL ? NULL : _xor(list->head->link, NULL),
    };
}

static Iterator _rbegin(const List *list)
{
    assert(list != NULL);

    Iterator it = _end(list);
    _previous(&it);
    return it;
}

static Iterator _end(const List *list)
{
    assert(list != NULL);

    Iterator it = _begin(list);

    while (it.current != NULL)
        _next(&it);

    return it;
}

static Iterator _rend(const List *list)
{
    assert(list != NULL);

    Iterator it = _begin(list);
    _previous(&it);
    return it;
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

static int _insert_before(Iterator *it, int value)
{
    assert(it != NULL);

    if (_is_rend(it))
        return 0;

    Node *node = NULL;

    if ((node = _new_node(value, it->previous, it->current)) == NULL)
        return 0;

    if (_is_empty(it->list) || _is_begin(it))
        it->list->head = node;

    if (it->previous != NULL)
        it->previous->link = _xor(_xor(it->previous->link, it->current), node);

    if (it->current != NULL)
        it->current->link = _xor(_xor(it->current->link, it->previous), node);

    it->previous = node;

    return 1;
}

static int _insert_after(Iterator *it, int value)
{
    assert(it != NULL);

    if (_is_end(it))
        return 0;

    Node *node = NULL;

    if ((node = _new_node(value, it->current, it->next)) == NULL)
        return 0;

    if (_is_empty(it->list) || _is_rend(it))
        it->list->head = node;

    if (it->current != NULL)
        it->current->link = _xor(_xor(it->current->link, it->next), node);

    if (it->next != NULL)
        it->next->link = _xor(_xor(it->next->link, it->current), node);

    it->next = node;

    return 1;
}

static int _is_empty(const List *list)
{
    assert(list != NULL);

    return list->head == NULL;
}

static int _is_begin(const Iterator *it)
{
    assert(it != NULL);

    return it->previous == NULL && it->current != NULL;
}

//static int _is_rbegin(const Iterator *it)
//{
//    assert(it != NULL);
//
//    return it->current == NULL && it->next == NULL;
//}

static int _is_end(const Iterator *it)
{
    assert(it != NULL);

    return it->previous != NULL && it->current == NULL;
}

static int _is_rend(const Iterator *it)
{
    return it->current == NULL && it->next != NULL;
}

