#include <iostream>
#include "array.hpp"

int main()
{
    Array<int> array(1);
    std::cout << array << std::endl;

    for (int i = 0; i < 10; i++) {
        array.push(i);
        std::cout << array << std::endl;
    }
    for (int i = 0; i < 10; i++) {
        array.pop();
        std::cout << array << std::endl;
    }
}

