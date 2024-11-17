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
        node_allocator m_node_allocator;
        Node *m_head;
        Node *m_tail;

    private:
        Node *new_node(const T &value)
        {
            Node *node = node_allocator_traits::allocate(m_node_allocator, 1);
            node_allocator_traits::construct(m_node_allocator, node, Node { value, nullptr });
            return node;
        }

        Node *delete_node(Node *node)
        {
            Node *next = node->next;
            node_allocator_traits::destroy(m_node_allocator, node);
            node_allocator_traits::deallocate(m_node_allocator, node, 1);
            return next;
        }

    public:
        List()
            : m_node_allocator(node_allocator()),
              m_head(nullptr),
              m_tail(nullptr)
        {
        }

        ~List()
        {
            clear();
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

        bool empty() const
        {
            return m_head == nullptr;
        }

        std::size_t size() const
        {
            std::size_t n = 0;

            for (Node *node = m_head; node != nullptr; node = node->next)
                n++;

            return n;
        }

        void clear()
        {
            for (Node *node = m_head; node != nullptr; node = delete_node(node));
            m_head = m_tail = nullptr;
        }

        void push_back(const T &value)
        {
            if (m_head == nullptr)
                m_head = m_tail = new_node(value);
            else
                m_tail = m_tail->next = new_node(value);
        }

        void pop_front()
        {
            if ((m_head = delete_node(m_head)) == nullptr)
                m_tail = nullptr;
        }

};

template
<
    typename T,
    typename Allocator = std::allocator<T>
>
std::ostream &operator<<(std::ostream &ostream, const List<T, Allocator> &list)
{
    ostream << "List("
            << "size=" << list.size() << ", "
            << "values=[";

    const char *separator = "";

    for (const T &value : list)
    {
        ostream << separator << value;
        separator = ", ";
    }

    ostream << "])";

    return ostream;
}

#endif

