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
XorLinkedList;

XorLinkedList *XorLinkedList_new(void);
Node *XorLinkedList_current(XorLinkedList *list);
Node *XorLinkedList_next(XorLinkedList *list);
Node *XorLinkedList_prev(XorLinkedList *list);
Node *XorLinkedList_insert_before(XorLinkedList *list, int value);
Node *XorLinkedList_insert_after(XorLinkedList *list, int value);
void XorLinkedList_free(XorLinkedList *list);
void XorLinkedList_dump(XorLinkedList *list);

#endif

