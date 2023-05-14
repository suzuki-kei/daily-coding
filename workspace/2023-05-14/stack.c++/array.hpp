#ifndef ARRAY_HPP_INCLUDED
#define ARRAY_HPP_INCLUDED

#include <algorithm>
#include <cstddef>
#include <iostream>
#include <memory>

/**
 *
 * 可変長配列 (Variable Length Array).
 *
 */
template
<
    // 要素の型.
    typename T,

    // メモリのアロケータ.
    typename Allocator = std::allocator<T>
>
class Array
{
private:
    using allocator_traits = std::allocator_traits<Allocator>;

private:
    // デフォルトの最小キャパシティ.
    static const std::size_t DEFAULT_MINIMUM_CAPACITY = 16;

private:
    // 要素数.
    std::size_t m_size;

    // キャパシティ (メモリを再割り当てせずに保持可能な要素数).
    std::size_t m_capacity;

    // 要素を保持するメモリのアロケータ.
    Allocator m_allocator;

    // 要素を保持するメモリ.
    T *m_memory;

protected:
    /**
     *
     * 適切なキャパシティを計算する.
     *
     * @param minimum_capacity
     *     最低限必要なキャパシティを指定する.
     *
     * @return
     *     minimum_capacity から求めたキャパシティ.
     *     必ず minimum_capacity 以上の値を返す.
     *
     */
    static std::size_t compute_capacity(std::size_t minimum_capacity)
    {
        std::size_t capacity = 1;

        while (capacity < minimum_capacity)
            capacity *= 2;
        return capacity;
    }

protected:
    /**
     *
     * 内部状態を交換する.
     *
     * @param array
     *     内部状態を交換する対象.
     *
     */
    virtual void swap(Array<T> &array)
    {
        std::swap(m_size, array.m_size);
        std::swap(m_capacity, array.m_capacity);
        std::swap(m_memory, array.m_memory);
        std::swap(m_allocator, array.m_allocator);
    }

public:
    /**
     *
     * コンストラクタ.
     *
     * デフォルトのキャパシティで初期化する.
     *
     */
    Array()
        : Array(DEFAULT_MINIMUM_CAPACITY)
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
    Array(std::size_t minimum_capacity)
        : m_size(0),
          m_capacity(compute_capacity(minimum_capacity)),
          m_memory(allocator_traits::allocate(m_allocator, m_capacity))
    {
    }

    /**
     *
     * コンストラクタ.
     *
     * @param array
     *     コピー元の Array.
     *
     * @param minimum_capacity
     *     最低限必要なキャパシティを指定する.
     *
     */
    Array(const Array<T> &array, std::size_t minimum_capacity)
        : m_size(array.m_size),
          m_capacity(compute_capacity(std::max(array.m_capacity, minimum_capacity))),
          m_allocator(array.m_allocator),
          m_memory(allocator_traits::allocate(m_allocator, m_capacity))
    {
        for (std::size_t i = 0; i < array.m_size; i++)
            new(&m_memory[i]) T(array.m_memory[i]);
    }

    /**
     *
     * コピーコンストラクタ.
     *
     * @param array
     *     コピー元の Array.
     *
     */
    Array(const Array<T> &array)
        : Array(array, array.m_capacity)
    {
    }

    /**
     *
     * デストラクタ.
     *
     */
    virtual ~Array()
    {
        for (std::size_t i = 0; i < m_size; i++)
            allocator_traits::destroy(m_allocator, &m_memory[i]);
        m_allocator.deallocate(m_memory, m_capacity);
    }

    /**
     *
     * 代入演算子.
     *
     * @param array
     *     右辺値となる Array.
     *
     * @return
     *     このインスタンスの参照.
     *
     */
    virtual Array &operator=(const Array &array)
    {
        Array(array).swap(*this);
        return *this;
    }

    /**
     *
     * 要素の参照を返す.
     *
     * @param i
     *     要素のインデックス.
     *
     * @return
     *     i 番目の要素の参照.
     *
     */
    virtual T &operator[](std::size_t i)
    {
        return m_memory[i];
    }

    /**
     *
     * 要素の const 参照を返す.
     *
     * @param i
     *     要素のインデックス.
     *
     * @return
     *     i 番目の要素の const 参照.
     *
     */
    virtual const T &operator[](std::size_t i) const
    {
        return m_memory[i];
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
        return m_size == 0;
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
        return m_size;
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
        return m_capacity;
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
        if (m_size == m_capacity)
            Array(*this, m_capacity + 1).swap(*this);
        allocator_traits::construct(m_allocator, &m_memory[m_size], value);
        m_size++;
    }

    /**
     *
     * 末尾の要素を削除する.
     *
     */
    virtual void pop()
    {
        if (m_size == 0)
            throw std::exception();

        allocator_traits::destroy(m_allocator, &m_memory[m_size - 1]);
        m_size--;
    }

    /**
     *
     * 全ての要素を削除する.
     *
     */
    virtual void clear()
    {
        while (!empty())
            pop();
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

        stream << "Array(";
        stream << "size=" << m_size << ", ";
        stream << "capacity=" << m_capacity << ", ";
        stream << "values=[";

        for (std::size_t i = 0; i < m_size; i++)
        {
            stream << delimiter << m_memory[i];
            delimiter = ", ";
        }
        stream << "])";
    }
};

/**
 *
 * Array を std::ostream に出力する.
 *
 * @param stream
 *     std::ostream の参照.
 *
 * @param array
 *     Array の const 参照.
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
std::ostream &operator<<(std::ostream &stream, const Array<T, Allocator> &array)
{
    array.print(stream);
    return stream;
}

#endif

