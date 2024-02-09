#include <iostream>
#include <random>

int main()
{
    std::random_device random_device;
    std::mt19937 random_engine(random_device());
    std::uniform_int_distribution<int> uniform_distribution(10, 99);

    const char *separator = "";

    for (int i = 0; i < 20; i++)
    {
        std::cout << separator << uniform_distribution(random_engine);
        separator = " ";
    }
    std::cout << std::endl;

    return 0;
}

