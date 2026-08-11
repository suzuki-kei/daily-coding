#ifndef XOR_LINKED_LIST_INCLUDED
#define XOR_LINKED_LIST_INCLUDED

typedef struct Node
{
    int value;
    struct Node *pointer;
}
Node;

typedef struct
{
    Node *current;
    Node *prev;
    Node *next;
}
List;

List *XorLinkedList_new(void);
Node *XorLinkedList_current(List *list);
Node *XorLinkedList_next(List *list);
Node *XorLinkedList_prev(List *list);
Node *XorLinkedList_insert_before(List *list, int value);
Node *XorLinkedList_insert_after(List *list, int value);
void XorLinkedList_free(List *list);
void XorLinkedList_dump(List *list);

#endif

