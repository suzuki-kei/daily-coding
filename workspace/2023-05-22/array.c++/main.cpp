#include "array.hpp"
#include <iostream>

int main()
{
    Array<int> array(0);
    std::cout << array << std::endl;

    const int n = 10;

    for (int i = 0; i < n; i++) {
        array.push(i);
        std::cout << array << std::endl;
    }
    for (int i = 0; i < n; i++) {
        array.pop();
        std::cout << array << std::endl;
    }

    return 0;
}

