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

    public:
        template
        <
            typename ReferenceType
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

                bool operator==(const Iterator &iterator) const
                {
                    return m_node == iterator.m_node;
                }

                ReferenceType operator*() const
                {
                    return m_node->value;
                }

                Iterator &operator++()
                {
                    m_node = m_node->next;
                    return *this;
                }
        };

    public:
        using allocator = Allocator;
        using allocator_traits = std::allocator_traits<allocator>;
        using node_allocator = typename allocator_traits::template rebind_alloc<Node>;
        using node_allocator_traits = typename allocator_traits::template rebind_traits<Node>;
        using iterator = Iterator<T &>;
        using const_iterator = Iterator<const T &>;

    private:
        node_allocator m_node_allocator;
        Node *m_head;
        Node *m_tail;

    private:
        Node *new_node(const T &value, Node *next=nullptr)
        {
            Node *node = node_allocator_traits::allocate(m_node_allocator, 1);
            node_allocator_traits::construct(m_node_allocator, node, Node { value, next });
            return node;
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

        iterator begin()
        {
            return iterator(m_head);
        }

        const_iterator begin() const
        {
            return const_iterator(m_head);
        }

        iterator end()
        {
            return iterator(nullptr);
        }

        const_iterator end() const
        {
            return const_iterator(nullptr);
        }

        void clear()
        {
            Node *node = m_head;

            while (node != nullptr)
            {
                Node *next = node->next;
                node_allocator_traits::deallocate(m_node_allocator, node, 1);
                node = next;
            }

            m_head = m_tail = nullptr;
        }

        void add(const T &value)
        {
            if (m_head == nullptr)
                m_head = m_tail = new_node(value);
            else
                m_tail = m_tail->next = new_node(value);
        }
};

template
<
    typename T
>
std::ostream &operator<<(std::ostream &ostream, const List<T> &list)
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

