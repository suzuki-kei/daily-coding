#ifndef RANDOM_INCLUDED
#define RANDOM_INCLUDED

#include <random>

class Random
{
    private:
        std::default_random_engine m_engine;

    private:
        static std::default_random_engine new_engine()
        {
            std::random_device device;
            std::default_random_engine engine(device());
            return engine;
        }

    public:
        Random()
            : m_engine(new_engine())
        {
        }

        int next(int min, int max)
        {
            std::uniform_int_distribution<int> distribution(min, max);
            return distribution(m_engine);
        }
};

#endif

