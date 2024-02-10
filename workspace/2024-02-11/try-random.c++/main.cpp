#include <iostream>
#include <random>

int main()
{
    std::random_device device;
    std::mt19937 engine(device());
    std::uniform_int_distribution<int> distribution(10, 99);

    const char *separator = "";

    for (int i = 0; i < 20; i++)
    {
        std::cout << separator << distribution(engine);
        separator = " ";
    }
    std::cout << std::endl;

    return 0;
}

