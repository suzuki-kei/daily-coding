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
    Node *previous;
    Node *current;
    Node *next;
}
Iterator;

List *XorLinkedList_new(void);
List *XorLinkedList_from_array(const int *array, int n);
void XorLinkedList_clean(List *list);
void XorLinkedList_free(List *list);
int XorLinkedList_is_empty(const List *list);
int XorLinkedList_equals(const List *list1, const List *list2);
int XorLinkedList_length(const List *list);
void XorLinkedList_reverse(List *list);
void XorLinkedList_print(const List *list);
Iterator XorLinkedList_begin(const List *list);
Node *XorLinkedList_previous(Iterator *it);
Node *XorLinkedList_next(Iterator *it);
Node *XorLinkedList_insert_before(Iterator *it, int value);
Node *XorLinkedList_insert_after(Iterator *it, int value);
int XorLinkedList_delete(Iterator *it);

#endif

