#include <iostream>
#include <random>
#include <vector>

class Random
{
    private:
        std::random_device m_device;
        std::default_random_engine m_engine;

    public:
        Random()
            : m_device(std::random_device())
            , m_engine(std::default_random_engine(m_device()))
        {
        }

        double operator()(double begin, double end)
        {
            std::uniform_real_distribution<double> distribution(begin, end);
            return distribution(m_engine);
        }

        double operator()()
        {
            return (*this)(0.0, 1.0);
        }
};

std::vector<int> selection_without_replacement(Random &random, int n, int min, int max);
std::ostream &operator<<(std::ostream &ostream, const std::vector<int> &values);

int main()
{
    Random random;
    std::cout << selection_without_replacement(random, 20, 0, 9) << std::endl;
    std::cout << selection_without_replacement(random, 20, 10, 99) << std::endl;

    return 0;
}

std::vector<int> selection_without_replacement(Random &random, int n, int min, int max)
{
    std::vector<int> values;

    for (int value = min; value <= max; value++)
    {
        const int n_remaining = n - values.size();
        const int n_candidates_remaining = max - value + 1;
        const double selection_probability = n_remaining / static_cast<double>(n_candidates_remaining);

        if (random() < selection_probability)
            values.push_back(value);
    }

    return values;
}

std::ostream &operator<<(std::ostream &ostream, const std::vector<int> &values)
{
    const char *separator = "";

    for (const int value : values)
    {
        ostream << separator << value;
        separator = " ";
    }

    return ostream;
}

