#include "integer.hpp"
#include "array.hpp"
#include "stack.hpp"
#include <iostream>

void example1(int n=10)
{
    std::cout << "======== example1" << std::endl;

    Array<Integer> array(0);

    for (int i = 0; i < n; i++) {
        array.push(Integer(i));
        std::cout << array << std::endl;
    }
    for (int i = 0; i < n; i++) {
        array.pop();
        std::cout << array << std::endl;
    }
}

void example2(int n=10)
{
    std::cout << "======== example2" << std::endl;

    Array<Integer> array1;
    Array<Integer> array2;

    for (std::size_t i = 0; i < n; i++)
    {
        array1.push(Integer(i + 10));
        array2.push(Integer(i + 20));
    }

    std::cout << "array1 = " << array1 << std::endl;
    std::cout << "array2 = " << array2 << std::endl;

    std::swap(array1, array2);
    std::cout << "array1 = " << array1 << std::endl;
    std::cout << "array2 = " << array2 << std::endl;
}

void example3(int n=10)
{
    std::cout << "======== example3" << std::endl;

    Stack<Integer> stack(0);

    for (int i = 0; i < n; i++) {
        stack.push(Integer(i));
        std::cout << stack << std::endl;
    }
    for (int i = 0; i < n; i++) {
        stack.pop();
        std::cout << stack << std::endl;
    }
}

void example4(int n=10)
{
    std::cout << "======== example4" << std::endl;

    Stack<Integer> stack1;
    Stack<Integer> stack2;

    for (std::size_t i = 0; i < n; i++)
    {
        stack1.push(Integer(i + 10));
        stack2.push(Integer(i + 20));
    }

    std::cout << "stack1 = " << stack1 << std::endl;
    std::cout << "stack2 = " << stack2 << std::endl;

    std::swap(stack1, stack2);
    std::cout << "stack1 = " << stack1 << std::endl;
    std::cout << "stack2 = " << stack2 << std::endl;
}

int main()
{
    Integer::TRACE = false;

    example1();
    example2();
    example3();
    example4();
    return 0;
}

