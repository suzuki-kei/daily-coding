#include <iostream>
#include <random>
#include <vector>

struct Range
{
    int begin;
    int end;
};

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

        double uniform()
        {
            return uniform(Range(0.0, 1.0));
        }

        double uniform(const Range &range)
        {
            std::uniform_real_distribution<double> distribution(range.begin, range.end);
            return distribution(m_engine);
        }
};

std::vector<int> selection_without_replacement(Random &random, int n, const Range &range);
std::ostream &operator<<(std::ostream &ostream, const std::vector<int> &values);

int main()
{
    Random random;
    std::cout << selection_without_replacement(random, 20, Range(0, 10)) << std::endl;
    std::cout << selection_without_replacement(random, 20, Range(10, 100)) << std::endl;
    return 0;
}

std::vector<int> selection_without_replacement(Random &random, int n, const Range &range)
{
    std::vector<int> values;
    values.reserve(n);

    for (int value = range.begin; value < range.end; value++)
    {
        const int n_remaining = n - values.size();
        const int n_candidates_remainings = range.end - value;
        const double selection_probability = n_remaining / static_cast<double>(n_candidates_remainings);

        if (random.uniform() < selection_probability)
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

