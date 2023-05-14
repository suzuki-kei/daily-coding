#ifndef STACK_HPP_INCLUDED
#define STACK_HPP_INCLUDED

#include "array.hpp"
#include "stack.hpp"
#include <cstddef>
#include <iostream>
#include <memory>

/**
 *
 * Stack.
 *
 */
template
<
    typename T,
    typename Allocator = std::allocator<T>
>
class Stack
{
private:
    // デフォルトの最小キャパシティ.
    static const std::size_t DEFAULT_MINIMUM_CAPACITY = 16;

private:
    // Array で Stack を実装する.
    Array<T, Allocator> m_array;

protected:
    /**
     *
     * 内部状態を交換する.
     *
     * @param stack
     *     内部状態を交換する対象.
     *
     */
    virtual void swap(Stack<T> &stack)
    {
        std::swap(m_array, stack.m_array);
    }

public:
    /**
     *
     * コンストラクタ.
     *
     */
    Stack()
        : Stack(DEFAULT_MINIMUM_CAPACITY)
    {
    }

    /**
     *
     * コンストラクタ.
     *
     * @param minimum_capacity
     *     最低限必要なキャパシティを指定する.
     *
     */
    Stack(std::size_t minimum_capacity)
        : m_array(minimum_capacity)
    {
    }

    /**
     *
     * コピーコンストラクタ.
     *
     * @param stack
     *     コピー元の Stack.
     *
     */
    Stack(const Stack &stack)
        : m_array(stack.m_array)
    {
    }

    /**
     *
     * デストラクタ.
     *
     */
    virtual ~Stack()
    {
        m_array.clear();
    }

    /**
     *
     * 代入演算子.
     *
     * @param stack
     *     右辺値となる Stack.
     *
     * @return
     *     このインスタンスの参照.
     *
     */
    virtual Stack &operator=(const Stack &stack)
    {
        Stack(stack).swap(*this);
        return *this;
    }

    /**
     *
     * コンテナが空であることを判定する.
     *
     * @return
     *     コンテナが空の場合に true.
     *     そうではない場合は false.
     *
     */
    virtual bool empty() const
    {
        return m_array.empty();
    }

    /**
     *
     * コンテナの要素数を返す.
     *
     * @return
     *     コンテナの要素数.
     *
     */
    virtual std::size_t size() const
    {
        return m_array.size();
    }

    /**
     *
     * コンテナのキャパシティを返す.
     *
     * キャパシティまではメモリを再割り当てせずに要素を追加できる.
     *
     * @return
     *     コンテナのキャパシティ.
     *
     */
    virtual std::size_t capacity() const
    {
        return m_array.capacity();
    }

    /**
     *
     * 要素を末尾に追加する.
     *
     * @param value
     *     追加する値.
     *
     */
    virtual void push(const T &value)
    {
        m_array.push(value);
    }

    /**
     *
     * 末尾の要素を削除する.
     *
     */
    virtual void pop()
    {
        m_array.pop();
    }

    /**
     *
     * 全ての要素を削除する.
     *
     */
    virtual void clear()
    {
        m_array.clear();
    }

    /**
     *
     * 文字列表現を std::ostream に出力する.
     *
     * @param stream
     *     std::ostream の参照.
     *
     * @return
     *     引数で受け取った std::ostream の参照.
     *
     */
    virtual void print(std::ostream &stream) const
    {
        const char *delimiter = "";

        stream << "Stack(";
        stream << "size=" << size() << ", ";
        stream << "capacity=" << capacity() << ", ";
        stream << "values=[";

        for (std::size_t i = 0; i < size(); i++)
        {
            stream << delimiter << m_array[i];
            delimiter = ", ";
        }
        stream << "])";
    }
};

/**
 *
 * Stack を std::ostream に出力する.
 *
 * @param stream
 *     std::ostream の参照.
 *
 * @param stack
 *     Stack の const 参照.
 *
 * @return
 *     引数で受け取った std::ostream の参照.
 *
 */
template
<
    typename T,
    typename Allocator = std::allocator<T>
>
std::ostream &operator<<(std::ostream &stream, const Stack<T, Allocator> &stack)
{
    stack.print(stream);
    return stream;
}

#endif

