#include <iostream>
#include <vector>
#include <random>

class Random
{
    private:
        std::random_device m_device;
        std::default_random_engine m_engine;

    public:
        Random()
            : m_device()
            , m_engine(m_device())
        {
        }

        double next(double min, double max)
        {
            std::uniform_real_distribution<double> distribution(min, max);
            return distribution(m_engine);
        }
};

std::vector<int> selection_without_replacement(int min, int max, int n, Random &random);
std::ostream &operator<<(std::ostream &ostream, const std::vector<int> &vector);

int main()
{
    Random random;
    std::vector<int> values = selection_without_replacement(10, 99, 20, random);
    std::cout << values << std::endl;
    return 0;
}

std::vector<int> selection_without_replacement(int min, int max, int n, Random &random)
{
    std::vector<int> values;
    values.reserve(n);

    for (int value = min; value <= max; value++)
    {
        const double numerator = n - values.size();
        const double denominator = max - value + 1;
        const double r = random.next(0.0, 1.0);

        if (r < numerator / denominator)
            values.push_back(value);
    }

    return values;
}

std::ostream &operator<<(std::ostream &ostream, const std::vector<int> &vector)
{
    const char *separator = "";

    for (const double value : vector)
    {
        ostream << separator << value;
        separator = " ";
    }

    return ostream;
}

