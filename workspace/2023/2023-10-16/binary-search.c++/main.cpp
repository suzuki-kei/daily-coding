#include <iostream>
#include <cstdlib>
#include <ctime>

void initialize();
void demonstration();
void set_random_ascending_values(int *values, int size);
void print_values(const int *values, int size);
int binary_search(const int *values, int size, int target);
int binary_search(const int *values, int lower, int upper, int target);

int main()
{
    initialize();
    demonstration();

    return 0;
}

void initialize()
{
    std::srand(std::time(NULL));
}

void demonstration()
{
    const std::size_t SIZE = 20;
    int values[SIZE];

    set_random_ascending_values(values, SIZE);
    print_values(values, SIZE);

    for (int target = values[0] - 1; target <= values[SIZE - 1] + 1; target++)
    {
        const int index = binary_search(values, SIZE, target);
        std::cout << "target=" << target << ", index=" << index << std::endl;
    }
}

void set_random_ascending_values(int *values, int size)
{
    for (int i = 0, offset = 10; i < size; offset = values[i++])
        values[i] = std::rand() % 5 + 1 + offset;
}

void print_values(const int *values, int size)
{
    const char *delimiter = "";

    for (int i = 0; i < size; i++)
    {
        std::cout << delimiter << values[i];
        delimiter = " ";
    }
    std::cout << std::endl;
}

int binary_search(const int *values, int size, int target)
{
    return binary_search(values, 0, size - 1, target);
}

int binary_search(const int *values, int lower, int upper, int target)
{
    const int center = (lower + upper) / 2;

    if (center < lower || upper < center)
        return -1;

    if (target < values[center])
        return binary_search(values, lower, center - 1, target);
    if (target > values[center])
        return binary_search(values, center + 1, upper, target);
    return center;
}

