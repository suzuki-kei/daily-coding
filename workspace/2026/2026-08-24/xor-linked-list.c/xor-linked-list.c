#include "xor-linked-list.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define _PRE_CONDITION(condition) \
    _pre_condition(#condition, condition)

void _pre_condition(const char *label, int condition);
List *_new_list(Node *head);
Node *_new_node(int value, Node *prev, Node *next);
void _free(List *list);
void _clear(List *list);
Iterator _begin(List *list);
Iterator _end(List *list);
Node *_next(Iterator *it);
Node *_prev(Iterator *it);
Node *_insert_before(Iterator *it, int value);
Node *_insert_after(Iterator *it, int value);
int _is_before_first(const Iterator *it);
int _is_after_last(const Iterator *it);
Node *_xor(Node *p1, Node *p2);

List *XorLinkedList_new(void)
{
    return _new_list(NULL);
}

List *XorLinkedList_from_array(const int *array, int n)
{
    _PRE_CONDITION(array != NULL);
    _PRE_CONDITION(n >= 0);

    List *list = NULL;

    if ((list = _new_list(NULL)) == NULL)
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

void XorLinkedList_free(List *list)
{
    _free(list);
}

void XorLinkedList_clear(List *list)
{
    _PRE_CONDITION(list != NULL);

    _clear(list);
}

int XorLinkedList_equals(List *list1, List *list2)
{
    _PRE_CONDITION(list1 != NULL);
    _PRE_CONDITION(list2 != NULL);

    Iterator it1 = _begin(list1);
    Iterator it2 = _begin(list2);

    while (it1.current != NULL && it2.current != NULL)
    {
        if (it1.current->value != it2.current->value)
            return 0;

        _next(&it1);
        _next(&it2);
    }

    return it1.current == it2.current;
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

Iterator XorLinkedList_rbegin(List *list)
{
    _PRE_CONDITION(list != NULL);

    Iterator it = _begin(list);

    while (it.next != NULL)
        _next(&it);

    return it;
}

Iterator XorLinkedList_end(List *list)
{
    _PRE_CONDITION(list != NULL);

    return _end(list);
}

Iterator XorLinkedList_rend(List *list)
{
    _PRE_CONDITION(list != NULL);

    Iterator it = _begin(list);

    while (it.current != NULL)
        _prev(&it);

    return it;
}

Node *XorLinkedList_next(Iterator *it)
{
    _PRE_CONDITION(it != NULL);

    return _next(it);
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

Node *XorLinkedList_insert_before(Iterator *it, int value)
{
    _PRE_CONDITION(it != NULL);

    return _insert_before(it, value);
}

Node *XorLinkedList_insert_after(Iterator *it, int value)
{
    _PRE_CONDITION(it != NULL);

    return _insert_after(it, value);
}

int XorLinkedList_delete(Iterator *it)
{
    _PRE_CONDITION(it != NULL);

    if (it->current == NULL)
        return 0;

    Node *node = it->current;
    Node *new_next = it->next == NULL ? NULL : _xor(it->next->link, it->current);

    if (it->current == it->list->head)
        it->list->head = it->next;

    if (it->prev != NULL)
        it->prev->link = _xor(_xor(it->prev->link, it->current), it->next);

    if (it->next != NULL)
        it->next->link = _xor(_xor(it->next->link, it->current), it->prev);

    it->current = it->next;
    it->next = new_next;

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

void _free(List *list)
{
    if (list != NULL)
        _clear(list);

    free(list);
}

void _clear(List *list)
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

Iterator _begin(List *list)
{
    assert(list != NULL);

    return (Iterator) {
        .list    = list,
        .prev    = NULL,
        .current = list->head,
        .next    = list->head == NULL ? NULL : list->head->link,
    };
}

Iterator _end(List *list)
{
    assert(list != NULL);

    Iterator it = _begin(list);

    while (it.current != NULL)
        _next(&it);

    return it;
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

Node *_insert_before(Iterator *it, int value)
{
    assert(it != NULL);

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
        it->current->link = _xor(_xor(it->current->link, it->prev), node);

    it->prev = node;

    return node;
}

Node *_insert_after(Iterator *it, int value)
{
    assert(it != NULL);

    if (_is_after_last(it))
        return NULL;

    Node *node = NULL;

    if ((node = _new_node(value, it->current, it->next)) == NULL)
        return NULL;

    if (it->current == NULL)
        it->list->head = node;
    else
        it->current->link = _xor(_xor(it->current->link, it->next), node);

    if (it->next != NULL)
        it->next->link = _xor(_xor(it->next->link, it->current), node);

    it->next = node;

    return node;
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

Node *_xor(Node *p1, Node *p2)
{
    return (Node *)(((uintptr_t) p1) ^ ((uintptr_t) p2));
}

