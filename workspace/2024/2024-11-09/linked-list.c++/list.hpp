#ifndef LIST_HPP_INCLUDED
#define LIST_HPP_INCLUDED

#include <memory>
#include <ostream>

template
<
    typename T,
    typename Allocator = std::allocator<T>
>
class List
{
    private:
        struct Node
        {
            public:
                T value;
                Node *next;
        };

        class Iterator
        {
            private:
                Node *m_node;

            public:
                Iterator(Node *node)
                    : m_node(node)
                {
                }

                T &operator*()
                {
                    return m_node->value;
                }

                const T &operator*() const
                {
                    return m_node->value;
                }

                Iterator &operator++()
                {
                    m_node = m_node->next;
                    return *this;
                }

                bool operator==(const Iterator &iterator) const
                {
                    return m_node == iterator.m_node;
                }
        };

    private:
        using allocator = Allocator;
        using allocator_traits = std::allocator_traits<allocator>;
        using node_allocator = typename allocator_traits::template rebind_alloc<Node>;
        using node_allocator_traits = typename allocator_traits::template rebind_traits<Node>;

    private:
        Node *m_head;
        Node *m_tail;
        node_allocator m_node_allocator;

    private:
        Node *new_node(const T &value, Node *next=nullptr)
        {
            Node *node = node_allocator_traits::allocate(m_node_allocator, 1);
            node_allocator_traits::construct(m_node_allocator, node, Node { value, next });
            return node;
        }

    public:
        List()
            : m_head(nullptr),
              m_tail(nullptr),
              m_node_allocator(node_allocator())
        {
        }

        ~List()
        {
            clear();
        }

        bool empty() const
        {
            return m_head == nullptr;
        }

        std::size_t size() const
        {
            std::size_t n = 0;

            for (const Node *node = m_head; node != nullptr; node = node->next)
                n++;

            return n;
        }

        void clear()
        {
            Node *node = m_head;

            while (node != nullptr)
            {
                Node *next = node->next;
                node_allocator_traits::destroy(m_node_allocator, node);
                node_allocator_traits::deallocate(m_node_allocator, node, 1);
                node = next;
            }
        }

        Iterator begin()
        {
            return Iterator(m_head);
        }

        const Iterator begin() const
        {
            return Iterator(m_head);
        }

        Iterator end()
        {
            return Iterator(nullptr);
        }

        const Iterator end() const
        {
            return Iterator(nullptr);
        }

        void append(const T &value)
        {
            if (m_head == nullptr)
                m_head = m_tail = new_node(value);
            else
                m_tail = m_tail->next = new_node(value);
        }
};

template
<
    typename T,
    typename Allocator
>
std::ostream &operator<<(std::ostream &ostream, const List<T, Allocator> &list)
{
    ostream << "List("
            << "size=" << list.size() << ", "
            << "values=[";

    const char *separator = "";

    for (const auto &value : list)
    {
        ostream << separator << value;
        separator = ", ";
    }

    ostream << "])";

    return ostream;
}

#endif

