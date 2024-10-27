#include "list.hpp"
#include <iostream>

int main()
{
    List<int> list;
    std::cout << list << std::endl;

    for (int i = 0; i < 10; i++)
    {
        list.insert(i / 2, i);
        std::cout << list << std::endl;
    }

    return 0;
}

