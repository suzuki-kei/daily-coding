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
List *XorLinkedList_from_list(const List *list);
List *XorLinkedList_from_array(const int *array, int n);
void XorLinkedList_free(List *list);
void XorLinkedList_clear(List *list);
int XorLinkedList_is_empty(const List *list);
int XorLinkedList_equals(const List *list1, const List *list2);
void XorLinkedList_print(const List *list);
Iterator XorLinkedList_begin(const List *list);
Iterator XorLinkedList_rbegin(const List *list);
Iterator XorLinkedList_end(const List *list);
Iterator XorLinkedList_rend(const List *list);
const Node *XorLinkedList_previous(Iterator *it);
const Node *XorLinkedList_next(Iterator *it);
int XorLinkedList_insert_before(Iterator *it, int value);
int XorLinkedList_insert_after(Iterator *it, int value);
int XorLinkedList_remove(Iterator *it);

#endif

