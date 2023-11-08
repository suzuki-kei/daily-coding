#include <iostream>
#include <vector>

template
<
    typename T,
    typename Allocator = std::allocator<T>
>
class Array
{
private:
    static const std::size_t N = 10;

private:
    T m_values[N];

public:
    Array()
    {
        for (std::size_t i = 0; i < N; i++)
            m_values[i] = T(i);
    }

    T *begin()
    {
        return &m_values[0];
    }

    T *end()
    {
        return &m_values[N];
    }

    const T *begin() const
    {
        return &m_values[0];
    }

    const T *end() const
    {
        return &m_values[N];
    }
};

template
<
    typename T
>
std::ostream &operator<<(std::ostream &ostream, const Array<T> &values)
{
    const char *delimiter = "";

    for (const auto &value : values)
    {
        ostream << delimiter << value;
        delimiter = " ";
    }

    return ostream;
}

template
<
    typename T
>
std::ostream &operator<<(std::ostream &ostream, const std::vector<T> &values)
{
    const char *delimiter = "";

    for (const auto &value : values)
    {
        ostream << delimiter << value;
        delimiter = " ";
    }

    return ostream;
}

int main()
{
    std::vector<int> values;
    Array<int> array;

    for (int i = 0; i < 10; i++)
        values.push_back(i);

    for (const auto &value : array)
        std::cout << value << std::endl;

    std::cout << values << std::endl;
    std::cout << array << std::endl;

    return 0;
}

