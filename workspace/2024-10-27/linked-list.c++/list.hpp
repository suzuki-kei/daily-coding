#ifndef LIST_HPP_INCLUDED
#define LIST_HPP_INCLUDED

#include <memory>
#include <ostream>

template
<
    typename T
>
class List
{
    private:
        struct Node
        {
            T value;
            Node *next;

            Node(const T &value, Node *next=nullptr)
                : value(value),
                  next(next)
            {
            }
        };

        template
        <
            typename NodePointer
        >
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

                Iterator operator++()
                {
                    m_node = m_node->next;
                    return *this;
                }

                Iterator operator++(int)
                {
                    Iterator iterator(m_node);
                    m_node = m_node->next;
                    return iterator;
                }

                bool operator==(const Iterator &iterator) const
                {
                    return m_node == iterator.m_node;
                }
        };

    private:
        using node_type = Node;
        using iterator_type = Iterator<Node *>;
        using const_iterator_type = Iterator<Node * const>;

    private:
        node_type *m_head;
        node_type *m_tail;

    private:
        List(const List *source)
            : m_head(nullptr),
              m_tail(nullptr)
        {
            if (source != nullptr)
                for (const T &value : *source)
                    add(value);
        }

    public:
        List()
            : List(nullptr)
        {
        }

        List(const List &source)
            : List(source)
        {
        }

        ~List()
        {
            clear();
        }

        T &operator[](std::size_t i)
        {
            node_type *node = m_head;

            while (i != 0)
            {
                node = node->next;
                i--;
            }

            return node->value;
        }

        iterator_type begin()
        {
            return iterator_type(m_head);
        }

        const_iterator_type begin() const
        {
            return const_iterator_type(m_head);
        }

        iterator_type end()
        {
            return iterator_type(nullptr);
        }

        const_iterator_type end() const
        {
            return const_iterator_type(nullptr);
        }

        std::size_t size() const
        {
            std::size_t n = 0;

            for (const_iterator_type it = begin(); it != end(); ++it)
                n++;

            return n;
        }

        void clear()
        {
            node_type *node = m_head;
            node_type *next = nullptr;

            while (node != nullptr)
            {
                next = node->next;
                delete node;
                node = next;
            }

            m_head = m_tail = nullptr;
        }

        void add(const T &value)
        {
            if (m_head == nullptr)
                m_head = m_tail = new node_type(value, nullptr);
            else
                m_tail = m_tail->next = new node_type(value, nullptr);
        }

        void insert(std::size_t i, const T &value)
        {
            if (i == 0)
            {
                m_head = new node_type(value, m_head);
            }
            else
            {
                node_type *node = m_head;

                while (i-- != 1)
                    node = node->next;

                if (node == nullptr)
                    m_head = m_tail = new node_type(value);
                else
                    node->next = new node_type(value, node->next);
            }
        }
};

template
<
    typename T
>
std::ostream &operator<<(std::ostream &ostream, const List<T> &list)
{
    ostream << "List(";

    const char *separator = "";

    for (const T &value : list)
    {
        ostream << separator << value;
        separator = ", ";
    }

    ostream << ")";

    return ostream;
}

#endif

