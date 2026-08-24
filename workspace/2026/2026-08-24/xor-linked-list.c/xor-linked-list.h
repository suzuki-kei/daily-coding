#ifndef XOR_LINKED_LIST_INCLUDED
#define XOR_LINKED_LIST_INCLUDED

typedef struct Node
{
    int value;
    struct Node *link;
}
Node;

typedef struct List
{
    Node *head;
}
List;

typedef struct Iterator
{
    List *list;
    Node *prev;
    Node *current;
    Node *next;
}
Iterator;

List *XorLinkedList_new(void);
List *XorLinkedList_from_array(const int *array, int n);
void XorLinkedList_free(List *list);
void XorLinkedList_clear(List *list);
int XorLinkedList_equals(List *list1, List *list2);
int XorLinkedList_length(List *list);
void XorLinkedList_print(List *list);
Iterator XorLinkedList_begin(List *list);
Iterator XorLinkedList_rbegin(List *list);
Iterator XorLinkedList_end(List *list);
Iterator XorLinkedList_rend(List *list);
Node *XorLinkedList_next(Iterator *it);
Node *XorLinkedList_current(Iterator *it);
Node *XorLinkedList_prev(Iterator *it);
Node *XorLinkedList_insert_before(Iterator *it, int value);
Node *XorLinkedList_insert_after(Iterator *it, int value);
int XorLinkedList_delete(Iterator *it);

#endif

