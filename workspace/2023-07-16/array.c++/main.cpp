#include "array.hpp"
#include <cassert>
#include <iostream>

void test();
void demonstration();

int main()
{
    test();
    demonstration();

    return 0;
}

void test()
{
    std::cout << "==== test" << std::endl;

    std::cout << "Array(std::size_t minimum_capacity=DEFAULT_MINIMUM_CAPACITY)" << std::endl;
    {
        Array<int> array;
        assert(array.empty());
        assert(array.size() == 0);
        assert(array.capacity() > 0);
    }

    std::cout << "Array(const Array &array, std::size_t minimum_capacity)" << std::endl;
    {
        Array<int> array1;
        array1.push(0);
        array1.push(1);
        array1.push(2);

        const std::size_t minimum_capacity = array1.capacity() * 2;
        Array<int> array2(array1, minimum_capacity);
        assert(!array2.empty());
        assert(array2.size() == 3);
        assert(array2.capacity() >= minimum_capacity);
        assert(array2[0] == 0);
        assert(array2[1] == 1);
        assert(array2[2] == 2);
    }

    std::cout << "Array(const Array &array)" << std::endl;
    {
        Array<int> array1;
        array1.push(0);
        array1.push(1);
        array1.push(2);

        Array<int> array2(array1);
        assert(!array2.empty());
        assert(array2.size() == 3);
        assert(array2.capacity() > 0);
        assert(array2[0] == 0);
        assert(array2[1] == 1);
        assert(array2[2] == 2);
    }

    std::cout << "virtual T &operator[](std::size_t i)" << std::endl;
    {
        Array<int> array;
        array.push(0);
        array.push(1);
        array.push(2);
        array[0] = 1;
        array[1] = 2;
        array[2] = 3;
        assert(array[0] == 1);
        assert(array[1] == 2);
        assert(array[2] == 3);
    }

    std::cout << "virtual const T &operator[](std::size_t i) const" << std::endl;
    {
        Array<int> array;
        array.push(0);
        array.push(1);
        array.push(2);
        assert(array[0] == 0);
        assert(array[1] == 1);
        assert(array[2] == 2);
    }

    std::cout << "virtual bool operator==(const Array &array) const" << std::endl;
    {
        Array<int> array1;
        Array<int> array2;
        assert(array1 == array2);

        array1.push(0);
        assert(array1 != array2);

        array2.push(0);
        assert(array1 == array2);
    }

    std::cout << "virtual bool empty() const" << std::endl;
    {
        Array<int> array;
        assert(array.empty());

        array.push(0);
        assert(!array.empty());
    }

    std::cout << "virtual std::size_t size() const" << std::endl;
    {
        Array<int> array;
        assert(array.size() == 0);

        array.push(0);
        assert(array.size() == 1);

        array.push(1);
        assert(array.size() == 2);

        array.push(2);
        assert(array.size() == 3);
    }

    std::cout << "virtual std::size_t capacity() const" << std::endl;
    {
        Array<int> array;
        assert(array.capacity() > 0);

        array.push(0);
        assert(array.capacity() > 1);

        array.push(1);
        assert(array.capacity() > 2);

        array.push(2);
        assert(array.capacity() > 3);
    }

    std::cout << "virtual void swap(Array &array)" << std::endl;
    {
        Array<int> array1;
        array1.push(1);
        array1.push(2);
        array1.push(3);

        Array<int> array2;
        array2.push(10);
        array2.push(20);
        array2.push(30);

        array1.swap(array2);
        assert(array1[0] == 10);
        assert(array1[1] == 20);
        assert(array1[2] == 30);
        assert(array2[0] == 1);
        assert(array2[1] == 2);
        assert(array2[2] == 3);
    }

    std::cout << "virtual void push(const T &value)" << std::endl;
    {
        Array<int> array;
        const int n = 10;

        for (int i = 0; i < n; i++)
        {
            array.push(i);
            assert(array.size() == i + 1);
        }
    }

    std::cout << "virtual void pop()" << std::endl;
    {
        Array<int> array;
        const int n = 10;

        for (int i = 0; i < n; i++)
            array.push(i);

        for (int i = 0; i < n; i++)
        {
            array.pop();
            assert(array.size() == n - i - 1);
        }
    }
}

void demonstration()
{
    std::cout << "==== demonstration" << std::endl;

    Array<int> array;
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

