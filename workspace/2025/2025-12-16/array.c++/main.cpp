#include "array.hpp"
#include <cstdio>
#include <iostream>

int main()
{
    Array<int> array(0);

    std::cout << array << std::endl;

    for (int i = 0; i < 10; i++)
    {
        array.push_back(i);
        std::cout << array << std::endl;
    }

    for (std::size_t i = 0; i < array.size(); i++)
        std::printf("array[%zu] = %d\n", i, array[i]);

    std::cout << array << std::endl;

    while (!array.empty())
    {
        array.pop_back();
        std::cout << array << std::endl;
    }

    return 0;
}

