#include <iostream>
#include <random>

int main()
{
    std::random_device device;
    std::mt19937 engine(device());
    std::uniform_int_distribution<int> distribution(10, 99);

    for (int i = 0; i < 10; i++)
        std::cout << distribution(engine) << std::endl;

    return 0;
}

