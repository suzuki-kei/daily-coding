#include "list.hpp"
#include <iostream>

int main()
{
    List<int> list;
    std::cout << list << std::endl;

    const int n = 10;

    for (int i = 0; i < n; i++) {
        list.push_front(i);
        std::cout << list << std::endl;
    }

    std::cout << "============================================================" << std::endl;
    List<int> list2(list);
    std::cout << list << std::endl;
    std::cout << list2 << std::endl;
    std::cout << "============================================================" << std::endl;

    for (int i = 0; i < n; i++) {
        list.pop_front();
        std::cout << list << std::endl;
    }


    return 0;
}

