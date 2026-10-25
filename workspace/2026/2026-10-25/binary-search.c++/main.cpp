#include "random.hpp"
#include <iostream>
#include <vector>

std::vector<int> selection_without_replacement(Random &random, int n, int min, int max);
std::ostream &operator<<(std::ostream &ostream, const std::vector<int> &values);
int binary_search(const std::vector<int> &values, int target);
int binary_search(const std::vector<int> &values, int target, int first, int last);

int main()
{
    Random random;
    std::vector<int> values = selection_without_replacement(random, 20, 11, 98);
    std::cout << values << std::endl;

    const int min_target = values.front() - 1;
    const int max_target = values.back() + 1;

    for (int target = min_target; target <= max_target; target++)
    {
        const int index = binary_search(values, target);
        std::printf("target = %2d, index = %d\n", target, index);
    }

    return 0;
}

std::vector<int> selection_without_replacement(Random &random, int n, int min, int max)
{
    std::vector<int> values;

    for (int x = min; x <= max; x++)
    {
        int n_remaining = n - values.size();
        int n_candidates_remainings = max - x + 1;
        double selection_probability = n_remaining / static_cast<double>(n_candidates_remainings);

        if (random.uniform() < selection_probability)
            values.push_back(x);
    }

    return values;
}

std::ostream &operator<<(std::ostream &ostream, const std::vector<int> &values)
{
    const char *separator = "";

    for (int value : values)
    {
        ostream << separator << value;
        separator = " ";
    }

    return ostream;
}

int binary_search(const std::vector<int> &values, int target)
{
    return binary_search(values, target, 0, values.size() - 1);
}

int binary_search(const std::vector<int> &values, int target, int first, int last)
{
    if (first > last)
        return -1;

    const int center = (first + last) / 2;

    if (target == values[center])
        return center;

    if (target < values[center])
        return binary_search(values, target, first, center - 1);
    else
        return binary_search(values, target, center + 1, last);
}

