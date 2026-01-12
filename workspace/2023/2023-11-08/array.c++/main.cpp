#include "array.hpp"
#include <iostream>

int main()
{
    Array<int> array(0);
    std::cout << array << std::endl;

    const int N = 10;

    for (int i = 0; i < N; i++)
    {
        array.push_back(i);
        std::cout << array << std::endl;
    }

    for (int i = 0; i < N; i++)
    {
        array.pop_back();
        std::cout << array << std::endl;
    }

    return 0;
}

