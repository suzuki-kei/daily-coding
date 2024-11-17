#include "list.hpp"
#include <iostream>

int main()
{
    List<int> list;
    std::cout << list << std::endl;

    for (int i = 0; i < 10; i++)
    {
        list.push_back(i);
        std::cout << list << std::endl;
    }

    while (!list.empty())
    {
        list.pop_front();
        std::cout << list << std::endl;
    }

    return 0;
}

