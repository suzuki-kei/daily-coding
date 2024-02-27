#include <algorithm>
#include <iostream>
#include <random>
#include <vector>

void set_random_ascending_values(std::vector<int>::iterator begin, std::vector<int>::iterator end);
std::ostream &operator<<(std::ostream &ostream, const std::vector<int> &values);
int binary_search(const std::vector<int> &values, int target);
int binary_search(const std::vector<int> &values, int target, int lower, int upper);

int main()
{
    std::vector<int> values(20);
    set_random_ascending_values(values.begin(), values.end());
    std::cout << values << std::endl;

    const int lower = values.front() - 1;
    const int upper = values.back() + 1;

    for (int target = lower; target <= upper; target++)
    {
        const int index = binary_search(values, target);
        std::cout << "target=" << target << ", index=" << index << std::endl;
    }

    return 0;
}

void set_random_ascending_values(std::vector<int>::iterator begin, std::vector<int>::iterator end)
{
    std::random_device device;
    std::mt19937 engine(device());
    std::uniform_int_distribution<int> distribution(1, 5);

    std::transform(begin, end, begin, [&](int _) {
        return distribution(engine);
    });
    std::inclusive_scan(begin, end, begin, std::plus(), 9);
}

std::ostream &operator<<(std::ostream &ostream, const std::vector<int> &values)
{
    const char *separator = "";

    for (const auto value : values)
    {
        std::cout << separator << value;
        separator = " ";
    }

    return ostream;
}

int binary_search(const std::vector<int> &values, int target)
{
    return binary_search(values, target, 0, values.size() - 1);
}

int binary_search(const std::vector<int> &values, int target, int lower, int upper)
{
    const int center = (lower + upper) / 2;

    if (center < lower || upper < center)
        return -1;
    if (target < values[center])
        return binary_search(values, target, lower, center - 1);
    if (target > values[center])
        return binary_search(values, target, center + 1, upper);
    return center;
}

