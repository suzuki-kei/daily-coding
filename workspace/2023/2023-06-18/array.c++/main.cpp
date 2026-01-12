#include "array.hpp"
#include <iostream>
#include <cassert>

void example();
void test();

int main()
{
    example();
    test();
    return 0;
}

void example()
{
    std::cout << "==== example" << std::endl;

    Array<int> array(1);
    std::cout << array << std::endl;

    const int n = 10;

    for (int i = 0; i < n; i++)
    {
        array.push(i);
        std::cout << array << std::endl;
    }

    for (int i = 0; i < n; i++)
    {
        array.pop();
        std::cout << array << std::endl;
    }
}

void test()
{
    std::cout << "==== test" << std::endl;

    {
        std::cout << "Array()" << std::endl;

        Array<int> array;
        assert(array.size() == 0);
        assert(array.capacity() > 0);
    }

    {
        std::cout << "Array(0)" << std::endl;

        Array<int> array(0);
        assert(array.size() == 0);
        assert(array.capacity() > 0);
    }

    {
        std::cout << "Array(const Array &array)" << std::endl;

        Array<int> array1;
        array1.push(1);
        array1.push(2);
        array1.push(3);

        Array<int> array2(array1);
        assert(array2.size() == 3);
        assert(array2[0] == 1);
        assert(array2[1] == 2);
        assert(array2[2] == 3);
    }

    {
        std::cout << "virtual Array &operator=(Array &array)" << std::endl;

        Array<int> array1;
        array1.push(1);
        array1.push(2);
        array1.push(3);

        Array<int> array2;
        array2 = array1;
        assert(array2.size() == 3);
        assert(array2[0] == 1);
        assert(array2[1] == 2);
        assert(array2[2] == 3);
    }

    {
        std::cout << "virtual bool operator==(const Array &array) const" << std::endl;

        Array<int> array1;
        Array<int> array2;
        assert(array1 == array1);
        assert(array1 == array2);

        array1.push(1);
        array2.push(1);
        assert(array1 == array1);
        assert(array1 == array2);
    }

    {
        std::cout << "virtual T &operator[](std::size_t i)" << std::endl;

        Array<int> array;
        array.push(0);
        array.push(0);
        array.push(0);

        array[0] = 1;
        assert(array[0] == 1);
        array[1] = 2;
        assert(array[1] == 2);
        array[2] = 3;
        assert(array[2] == 3);
    }

    {
        std::cout << "virtual const T &operator[](std::size_t i) const" << std::endl;

        Array<int> array;
        array.push(1);
        array.push(2);
        array.push(3);
        assert(array[0] == 1);
        assert(array[1] == 2);
        assert(array[2] == 3);
    }

    {
        std::cout << "virtual void swap(Array &array)" << std::endl;

        Array<int> array1;
        array1.push(1);
        array1.push(2);
        array1.push(3);

        Array<int> array2;
        array2.push(4);
        array2.push(5);
        array2.push(6);

        array1.swap(array2);
        assert(array1[0] == 4);
        assert(array1[1] == 5);
        assert(array1[2] == 6);
        assert(array2[0] == 1);
        assert(array2[1] == 2);
        assert(array2[2] == 3);
    }

    {
        std::cout << "virtual bool empty() const" << std::endl;

        Array<int> array;
        assert(array.empty());

        array.push(1);
        assert(!array.empty());
    }

    {
        std::cout << "virtual std::size_t size() const" << std::endl;

        Array<int> array;
        assert(array.size() == 0);

        for (int i = 0; i < 100; i++)
        {
            array.push(i);
            assert(array.size() == i + 1);
        }
    }

    {
        std::cout << "virtual std::size_t capacity() const" << std::endl;

        Array<int> array;
        assert(array.capacity() >= array.size());

        for (int i = 0; i < 100; i++)
        {
            array.push(i);
            assert(array.capacity() >= array.size());
        }
    }

    {
        std::cout << "virtual void push(const T &value)" << std::endl;

        Array<int> array;

        for (int i = 0; i < 100; i++)
        {
            array.push(i);
            assert(array[i] == i);
        }
    }

    {
        std::cout << "virtual void pop()" << std::endl;

        Array<int> array;
        const int n = 100;

        for (int i = 0; i < n; i++)
        {
            array.push(i);
            assert(array[i] == i);
        }

        for (int i = 0; i < n; i++)
        {
            array.pop();
            assert(array.size() == n - i - 1);
        }
    }
}

