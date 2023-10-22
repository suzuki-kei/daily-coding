#include "binary-search-tree.hpp"
#include <algorithm>
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <vector>

#define SIZE 10

void initialize(void);
void demonstration(void);
void set_random_values(int *values, int size);
void shuffle_values(int *values, int size);
int random_range(int min, int max);
void print_values(const int *values, int size);

int main()
{
    initialize();
    demonstration();

    return 0;
}

void initialize(void)
{
    std::srand(std::time(NULL));
}

void demonstration(void)
{
    int values[SIZE];
    set_random_values(values, SIZE);

    Tree<int> tree;

    {
        std::cout << "==== append" << std::endl;

        for (int i = 0; i < SIZE; i++)
        {
            tree.append(values[i]);
            std::cout << "[value=" << values[i] << "] " << tree << std::endl;
        }
    }

    {
        std::cout << "==== find" << std::endl;

        const int min = *std::min_element(values, values + SIZE);
        const int max = *std::max_element(values, values + SIZE);

        for (int target = min - 1; target <= max + 1; target++)
        {
            const Node<int> *node = tree.find(target);

            if (node != NULL)
                std::cout << "[value=" << target << "] " << node->value << std::endl;
        }
    }

    {
        std::cout << "==== remove" << std::endl;

        print_values(values, SIZE);
        shuffle_values(values, SIZE);
        print_values(values, SIZE);

        for (int i = 0; i < SIZE; i++)
        {
            tree.remove(values[i]);
            std::cout << "[value=" << values[i] << "] " << tree << std::endl;
        }
    }
}

void set_random_values(int *values, int size)
{
    for (int i = 0; i < size; i++)
        values[i] = std::rand() % 90 + 10;
}

void shuffle_values(int *values, int size)
{
    for (int lower = 0, upper = size - 1; lower < upper; lower++)
        std::swap(values[lower], values[random_range(lower, upper)]);
}

int random_range(int min, int max)
{
    return std::rand() % (max - min + 1) + min;
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

