#ifndef LIST_HPP_INCLUDED
#define LIST_HPP_INCLUDED

#include <iostream>
#include <memory>

template
<
    typename T
>
struct ListNode
{
    T value;
    ListNode<T> *next;
};

template
<
    typename T,
    typename Allocator = std::allocator<T>
>
class List
{
private:
    using Node = struct ListNode<T>;
    using NodeAllocator = typename std::allocator_traits<Allocator>::template rebind_alloc<Node>;
    using NodeAllocatorTraits = std::allocator_traits<NodeAllocator>;

private:
    NodeAllocator m_allocator;
    Node *m_head;

private:
    Node *new_node(const T &value, Node *next)
    {
        Node *node = NodeAllocatorTraits::allocate(m_allocator, 1);
        NodeAllocatorTraits::construct(m_allocator, node, Node{value, next});
        return node;
    }

    void delete_node(Node *node)
    {
        NodeAllocatorTraits::destroy(m_allocator, node);
        NodeAllocatorTraits::deallocate(m_allocator, node, 1);
    }

    Node *clone(const Node *source)
    {
        Node *head = NULL;
        Node **next = &head;

        for (const Node *node = source; node != NULL; node = node->next)
        {
            *next = new_node(node->value, NULL);
            next = &(*next)->next;
        }
        return head;
    }

public:
    List()
        : m_allocator(NodeAllocator()),
          m_head(NULL)
    {
    }

    List(const List &list)
        : m_allocator(list.m_allocator),
          m_head(clone(list.m_head))
    {
    }

    virtual ~List()
    {
        Node *node = m_head;

        while (node != NULL)
        {
            Node *next = node->next;
            delete_node(node);
            node = next;
        }
    }

    virtual bool empty() const
    {
        return m_head == NULL;
    }

    virtual std::size_t size() const
    {
        std::size_t count = 0;

        for (const Node *node = m_head; node != NULL; node = node->next)
            count++;
        return count;
    }

    virtual Node *head()
    {
        return m_head;
    }

    virtual const Node *head() const
    {
        return m_head;
    }

    virtual Node *tail()
    {
        Node *node = m_head;

        while (node != NULL && node->next != NULL)
            node = node->next;
        return node;
    }

    virtual const Node *tail() const
    {
        Node *node = m_head;

        while (node != NULL && node->next != NULL)
            node = node->next;
        return node;
    }

    virtual void push_front(const T &value)
    {
        m_head = new_node(value, m_head);
    }

    virtual void push_back(const T &value)
    {
        if (m_head == NULL)
            m_head = new_node(value, NULL);
        else
            tail()->next = new_node(value, NULL);
    }

    virtual void pop_front()
    {
        if (m_head == NULL)
            throw std::exception();

        Node *node = m_head;
        m_head = node->next;
        delete_node(node);
    }

    virtual void pop_back()
    {
        if (m_head == NULL)
            throw std::exception();

        Node **next = &m_head;
        while ((*next)->next != NULL)
            next = &(*next)->next;
        delete_node((*next)->next);
        *next = NULL;
    }
};

template
<
    typename T,
    typename Allocator = std::allocator<T>
>
std::ostream &operator<<(std::ostream &stream, const List<T, Allocator> &list)
{
    stream << "List(size=" << list.size() << ", values=[";

    const char *delimiter = "";

    for (const ListNode<T> *node = list.head(); node != NULL; node = node->next)
    {
        stream << delimiter << node->value;
        delimiter = ", ";
    }

    stream << "])";

    return stream;
}

#endif

