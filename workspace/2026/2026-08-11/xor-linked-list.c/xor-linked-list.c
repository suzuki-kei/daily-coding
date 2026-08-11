#include "xor-linked-list.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define xor(p1, p2) \
    ((Node *) (((uintptr_t) p1) ^ ((uintptr_t) p2)))

List *XorLinkedList_new(void)
{
    List *list = NULL;

    if ((list = malloc(sizeof(*list))) == NULL)
        return NULL;

    *list = (List) {0};
    return list;
}

Node *XorLinkedList_current(List *list)
{
    if (list == NULL)
        return NULL;

    return list->current;
}

Node *XorLinkedList_next(List *list)
{
    if (list == NULL || list->current == NULL || list->next == NULL)
        return NULL;

    Node *new_current = list->next;
    Node *new_prev = list->current;
    Node *new_next = xor(new_current->pointer, list->current);

    list->current = new_current;
    list->prev = new_prev;
    list->next = new_next;

    return new_current;
}

Node *XorLinkedList_prev(List *list)
{
    if (list == NULL || list->current == NULL || list->prev == NULL)
        return NULL;

    Node *new_current = list->prev;
    Node *new_prev = xor(new_current->pointer, list->current);
    Node *new_next = list->current;

    list->current = new_current;
    list->prev = new_prev;
    list->next = new_next;

    return new_current;
}

Node *XorLinkedList_insert_before(List *list, int value)
{
    if (list == NULL)
        return NULL;

    Node *node = NULL;

    if ((node = malloc(sizeof(Node))) == NULL)
        return NULL;

    node->value = value;
    node->pointer = xor(list->current, list->prev);

    if (list->current == NULL)
    {
        list->current = node;
        return node;
    }

    if (list->prev != NULL)
        list->prev->pointer = xor(xor(list->prev->pointer, list->current), node);

    list->current->pointer = xor(list->next, node);
    list->prev = node;

    return node;
}

Node *XorLinkedList_insert_after(List *list, int value)
{
    if (list == NULL)
        return NULL;

    Node *node = NULL;

    if ((node = malloc(sizeof(Node))) == NULL)
        return NULL;

    node->value = value;
    node->pointer = xor(list->current, list->next);

    if (list->current == NULL)
    {
        list->current = node;
        return node;
    }

    if (list->next != NULL)
        list->next->pointer = xor(xor(list->next->pointer, list->current), node);

    list->current->pointer = xor(list->prev, node);
    list->next = node;

    return node;
}

void XorLinkedList_free(List *list)
{
    if (list == NULL)
        return;

    while (XorLinkedList_prev(list) != NULL);

    Node *node = list->current;

    while (node != NULL)
    {
        Node *next = XorLinkedList_next(list);
        free(node);
        node = next;
    }

    free(list);
}

void XorLinkedList_dump(List *list)
{
    if (list == NULL)
    {
        printf("NULL\n");
        return;
    }

    const Node *current = list->current;
    while (XorLinkedList_prev(list) != NULL);

    printf("List([");

    const char *separator = "";

    for (Node *node = list->current; node != NULL; node = XorLinkedList_next(list))
    {
        if (node == current)
            printf("%s*%d*", separator, node->value);
    	else
            printf("%s%d", separator, node->value);
        separator = ", ";
    }

    printf("])\n");

    while (list->current != current)
        XorLinkedList_prev(list);
}

