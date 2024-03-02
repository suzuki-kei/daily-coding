#include <algorithm>
#include <iostream>
#include <random>
#include <vector>

void set_random_values(std::vector<int> &values);
void print_values(const std::vector<int> &values);
bool is_sorted(const std::vector<int> &values);
void quick_sort(std::vector<int> &values);
void quick_sort(std::vector<int> &values, int lower, int upper);

int main()
{
    std::vector<int> values(20);

    set_random_values(values);
    print_values(values);
    quick_sort(values);
    print_values(values);
}

void set_random_values(std::vector<int> &values)
{
    std::random_device device;
    std::mt19937 engine(device());
    std::uniform_int_distribution<int> distribution(10, 99);

    const auto transformer = [&engine, &distribution](int _) {
        return distribution(engine);
    };

    std::transform(values.begin(), values.end(), values.begin(), transformer);
}

void print_values(const std::vector<int> &values)
{
    const char *separator = "";

    for (const int value : values)
    {
        std::cout << separator << value;
        separator = " ";
    }

    if (is_sorted(values))
        std::cout << " (sorted)" << std::endl;
    else
        std::cout << " (not sorted)" << std::endl;
}

bool is_sorted(const std::vector<int> &values)
{
    for (std::vector<int>::size_type i = 0; i < values.size() - 1; i++)
        if (values[i] > values[i + 1])
            return false;

    return true;
}

void quick_sort(std::vector<int> &values)
{
    quick_sort(values, 0, values.size() - 1);
}

void quick_sort(std::vector<int> &values, int lower, int upper)
{
    int lower_index = lower;
    int upper_index = upper;
    const int pivot = values[(lower + upper) / 2];

    while (lower_index <= upper_index)
    {
        while (values[lower_index] < pivot)
            lower_index++;
        while (values[upper_index] > pivot)
            upper_index--;
        if (lower_index <= upper_index)
            std::swap(values[lower_index++], values[upper_index--]);
    }

    if (lower < upper_index)
        quick_sort(values, lower, upper_index);
    if (lower_index < upper)
        quick_sort(values, lower_index, upper);
}

