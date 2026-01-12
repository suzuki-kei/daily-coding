#include <iostream>

template
<
    typename T
>
struct DataType
{
};

template
<
>
struct DataType<int>
{
    static constexpr const char* NAME = "int";
};

template
<
>
struct DataType<double>
{
    static constexpr const char* NAME = "double";
};

int main()
{
    std::cout << DataType<int>::NAME << std::endl;
    std::cout << DataType<double>::NAME << std::endl;

    return 0;
}

