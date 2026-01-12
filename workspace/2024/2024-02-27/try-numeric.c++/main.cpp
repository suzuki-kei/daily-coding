#include <iostream>
#include <numeric>
#include <vector>

void print_vector(const std::vector<int> &values);

int main()
{
    // std::inclusive_scan() も std::exclusive_scan() も部分和を求める.
    // 両者の違いは最後の要素を含めるかどうか: [0, n] と [0, n) の違い.

    std::vector<int> values = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

    std::cout << "==== values" << std::endl;
    print_vector(values);

    ([values]() mutable {
        std::cout << "==== std::inclusive_scan" << std::endl;
        std::inclusive_scan(values.begin(), values.end(), values.begin(), std::plus(), 0);
        print_vector(values);
    })();

    ([values]() mutable {
        std::cout << "==== std::exclusive_scan" << std::endl;
        std::exclusive_scan(values.begin(), values.end(), values.begin(), 0, std::plus());
        print_vector(values);
    })();

    return 0;
}

void print_vector(const std::vector<int> &values)
{
    const char *separator = "";

    for (const auto &value : values)
    {
        std::cout << separator << value;
        separator = " ";
    }
    std::cout << std::endl;
}

