#include <algorithm>
#include <vector>
#include <functional>
#include <iostream>
#include <random>

class Random
{
    private:
        std::random_device m_device;
        std::mt19937 m_engine;

    public:
        Random()
            : m_device(std::random_device())
            , m_engine(m_device())
        {
        }

        int generate(int min, int max)
        {
            std::uniform_int_distribution<int> distribution(min, max);
            return distribution(m_engine);
        }
};

struct PartitionResult
{
    int left_upper;
    int right_lower;
};

typedef PartitionResult (*FnPartition)(std::vector<int> &array, int lower, int upper, Random &random);

void demonstration(const char *label, FnPartition partition, Random &random);
std::vector<int> generate_random_values(Random &random, int n);
std::ostream &operator<<(std::ostream &ostream, const std::vector<int> &values);
bool is_sorted(const std::vector<int> &values);
void quick_sort(std::vector<int> &values, FnPartition partition, Random &random);
void quick_sort(std::vector<int> &values, int lower, int upper, FnPartition partition, Random &random);
PartitionResult partition_2way(std::vector<int> &values, int lower, int upper, Random &random);
PartitionResult partition_3way(std::vector<int> &values, int lower, int upper, Random &random);
int random_select(std::vector<int> &values, int lower, int upper, Random &random);

int main()
{
    Random random;
    demonstration("partition 2-way", partition_2way, random);
    demonstration("partition 3-way", partition_3way, random);

    return 0;
}

void demonstration(const char *label, FnPartition partition, Random &random)
{
    std::cout << "==== " << label << std::endl;
    std::vector<int> values(generate_random_values(random, 20));
    std::cout << values << std::endl;
    quick_sort(values, partition, random);
    std::cout << values << std::endl;
}

std::vector<int> generate_random_values(Random &random, int n)
{
    std::vector<int> values(n);

    std::generate(values.begin(), values.end(), [&random]() {
        return random.generate(10, 99);
    });

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

    if (is_sorted(values))
        ostream << " (sorted)";
    else
        ostream << " (not sorted)";

    return ostream;
}

bool is_sorted(const std::vector<int> &values)
{
    for (std::vector<int>::size_type i = 0; i < values.size() - 1; i++)
        if (values[i] > values[i + 1])
            return false;

    return true;
}

void quick_sort(std::vector<int> &values, FnPartition partition, Random &random)
{
    quick_sort(values, 0, values.size() - 1, partition, random);
}

void quick_sort(std::vector<int> &values, int lower, int upper, FnPartition partition, Random &random)
{
    if (lower >= upper)
        return;

    const PartitionResult result = partition(values, lower, upper, random);
    quick_sort(values, lower, result.left_upper, partition, random);
    quick_sort(values, result.right_lower, upper, partition, random);
}

PartitionResult partition_2way(std::vector<int> &values, int lower, int upper, Random &random)
{
    int increment_index = lower;
    int decrement_index = upper;
    const int pivot = random_select(values, lower, upper, random);

    while (increment_index <= decrement_index)
    {
        while (values[increment_index] < pivot)
            increment_index++;
        while (values[decrement_index] > pivot)
            decrement_index--;
        if (increment_index <= decrement_index)
            std::swap(values[increment_index++], values[decrement_index--]);
    }

    return PartitionResult(decrement_index, increment_index);
}

PartitionResult partition_3way(std::vector<int> &values, int lower, int upper, Random &random)
{
    int less_end = lower;
    int increment_index = lower;
    int decrement_index = upper;
    const int pivot = random_select(values, lower, upper, random);

    while (increment_index <= decrement_index)
    {
        if (values[increment_index] < pivot)
            std::swap(values[less_end++], values[increment_index++]);
        else if (values[increment_index] > pivot)
            std::swap(values[increment_index], values[decrement_index--]);
        else
            increment_index++;
    }

    return PartitionResult(less_end - 1, increment_index);
}

int random_select(std::vector<int> &values, int lower, int upper, Random &random)
{
    return values[random.generate(lower, upper)];
}

