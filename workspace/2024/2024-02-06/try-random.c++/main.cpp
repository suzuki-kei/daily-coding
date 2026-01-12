#include <iostream>
#include <random>

class Random
{
    private:
        std::mt19937 m_random_engine;
        std::uniform_int_distribution<int> m_uniform_distribution;

    public:
        Random(int min=10, int max=99)
            : m_random_engine(std::random_device()()),
              m_uniform_distribution(min, max)
        {
        }

        int operator()()
        {
            return m_uniform_distribution(m_random_engine);
        }
};

int main()
{
    Random random;
    const char *separator = "";

    for (int i = 0; i < 20; i++)
    {
        std::cout << separator << random();
        separator = " ";
    }
    std::cout << std::endl;

    return 0;
}

