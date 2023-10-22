#ifndef BINARY_SEARCH_TREE_HPP
#define BINARY_SEARCH_TREE_HPP

#include <cstddef>
#include <ostream>

template
<
    typename T
>
struct Node
{
    T value;
    Node *left;
    Node *right;

    Node(const T value, Node *left=NULL, Node *right=NULL)
        : value(value), left(left), right(right)
    {
    }
};

template
<
    typename T
>
class Tree
{
private:
    Node<T> *m_root;

public:
    Tree()
        : m_root(NULL)
    {
    }

    ~Tree()
    {
        release(m_root);
    }

    void append(const T &value)
    {
        m_root = append(m_root, value);
    }

    const Node<T> *find(const T &target) const
    {
        return find(m_root, target);
    }

    bool remove(const T &target)
    {
        Node<T> *p_node = m_root;
        Node<T> **pp_node = &m_root;

        while (p_node != NULL && p_node->value != target)
        {
            if (target < p_node->value)
            {
                pp_node = &p_node->left;
                p_node = p_node->left;
                continue;
            }
            if (target > p_node->value)
            {
                pp_node = &p_node->right;
                p_node = p_node->right;
                continue;
            }
        }

        if (p_node == NULL)
            return false;

        while (p_node->left != NULL || p_node->right != NULL)
        {
            if (p_node->left != NULL)
            {
                p_node->value = p_node->left->value;
                pp_node = &p_node->left;
                p_node = p_node->left;
                continue;
            }
            if (p_node->right != NULL)
            {
                p_node->value = p_node->right->value;
                pp_node = &p_node->right;
                p_node = p_node->right;
                continue;
            }
        }

        *pp_node = NULL;
        delete p_node;
        return true;
    }

    void print(std::ostream &ostream) const
    {
        if (m_root == NULL)
            ostream << "()";
        else
            print(ostream, m_root);
    }

private:
    void release(Node<T> *node)
    {
        if (node == NULL)
            return;

        if (node->left != NULL)
        {
            release(node->left);
            delete node->left;
        }

        if (node->right != NULL)
        {
            release(node->right);
            delete node->right;
        }
    }

    Node<T> *append(Node<T> *node, const T &value)
    {
        if (node == NULL)
            return new Node<T>(value);

        if (value < node->value)
            node->left = append(node->left, value);
        else
            node->right = append(node->right, value);

        return node;
    }

    const Node<T> *find(const Node<T> *node, const T &target) const
    {
        if (node == NULL)
            return NULL;
        if (target < node->value)
            return find(node->left, target);
        if (target > node->value)
            return find(node->right, target);
        return node;
    }

    void print(std::ostream &ostream, const Node<T> *node) const
    {
        if (node == NULL)
            return;

        ostream << "(";

        if (node->left != NULL)
        {
            print(ostream, node->left);
            ostream << " ";
        }

        ostream << node->value;

        if (node->right != NULL)
        {
            ostream << " ";
            print(ostream, node->right);
        }

        ostream << ")";
    }
};

template
<
    typename T
>
std::ostream &operator<<(std::ostream &ostream, const Tree<T> &tree)
{
    tree.print(ostream);
    return ostream;
}

#endif

