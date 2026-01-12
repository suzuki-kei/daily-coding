#include "array.hpp"
#include <cassert>

void Array_test()
{
    std::cout << "==== test" << std::endl;

    // Array(std::size_t minimum_capacity=DEFAULT_MINIMUM_CAPACITY)
    {
        {
            Array<int> array(0);
            assert(array.size() == 0);
            assert(array.capacity() >= 1);
        }

        {
            Array<int> array(7);
            assert(array.size() == 0);
            assert(array.capacity() >= 7);
        }
    }

    // Array(const Array &array)
    {
        Array<int> array1;
        array1.push(1);
        array1.push(2);
        array1.push(3);

        Array<int> array2(array1);
        assert(array1 == array2);
    }

    // const Array &operator=(const Array &array)
    {
        Array<int> array1;
        array1.push(1);
        array1.push(2);
        array1.push(3);

        Array<int> array2;
        array2 = array1;
        assert(array1 == array2);
    }

    // bool operator==(const Array &array) const
    {
        Array<int> array1;
        Array<int> array2;

        assert(array1 == array2);

        array1.push(1);
        assert(array1 != array2);
    }

    // T &operator[](std::size_t i)
    {
        Array<int> array;
        array.push(1);
        array.push(2);
        array.push(3);

        int &value1 = array[0];
        assert(value1 == 1);

        int &value2 = array[1];
        assert(value2 == 2);

        int &value3 = array[2];
        assert(value3 == 3);

        try {
            int &value4 = array[3];
            (void)value4; // prevent warning: unused-variable
            assert(false); // NG
        } catch(std::exception &exception) {
            // OK
        }
    }

    // const int &operator[](std::size_t i) const
    {
        Array<int> array;
        array.push(1);
        array.push(2);
        array.push(3);

        const int &value1 = array[0];
        assert(value1 == 1);

        const int &value2 = array[1];
        assert(value2 == 2);

        const int &value3 = array[2];
        assert(value3 == 3);

        try {
            const int &value4 = array[3];
            (void)value4; // prevent warning: unused-variable
            assert(false); // NG
        } catch(std::exception &exception) {
            // OK
        }
    }

    // void swap(Array &array)
    {
        Array<int> array1;
        Array<int> array2;

        array1.push(1);
        array2.push(2);
        array1.swap(array2);
        assert(array1[0] == 2);
        assert(array2[0] == 1);
    }

    // bool empty() const
    {
        Array<int> array;
        assert(array.empty());

        array.push(1);
        assert(!array.empty());

        array.pop();
        assert(array.empty());
    }

    // std::size_t size() const
    {
        Array<int> array;
        assert(array.size() == 0);

        array.push(1);
        assert(array.size() == 1);

        array.pop();
        assert(array.size() == 0);
    }

    // std::size_t capacity() const
    {
        Array<int> array(0);
        assert(0 <= array.capacity() && array.size() <= array.capacity());

        const int n = 100;

        for (int i = 0; i < n; i++)
        {
            array.push(1);
            assert(0 <= array.capacity() && array.size() <= array.capacity());
        }

        for (int i = 0; i < n; i++)
        {
            array.pop();
            assert(0 <= array.capacity() && array.size() <= array.capacity());
        }
    }

    // void push(const T &value)
    {
        Array<int> array;

        array.push(1);
        assert(array[array.size() - 1] == 1);

        array.push(2);
        assert(array[array.size() - 1] == 2);

        array.push(3);
        assert(array[array.size() - 1] == 3);
    }

    // void pop()
    {
        Array<int> array;

        const int n = 100;

        for (int i = 0; i < n; i++)
            array.push(1);

        for (int i = 0; i < n; i++)
        {
            array.pop();
            assert(array.size() == n - i - 1);
        }
    }

    std::cout << "OK" << std::endl;
}

void Array_demonstration()
{
    std::cout << "==== demonstration" << std::endl;

    Array<int> array(0);
    std::cout << array << std::endl;

    const int n = 10;

    for (std::size_t i = 0; i < n; i++)
    {
        array.push(i);
        std::cout << array << std::endl;
    }

    for (std::size_t i = 0; i < n; i++)
    {
        array.pop();
        std::cout << array << std::endl;
    }
}

