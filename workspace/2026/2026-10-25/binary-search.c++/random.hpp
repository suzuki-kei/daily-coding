#ifndef RANDOM_INCLUDED
#define RANDOM_INCLUDED

#include <random>

class Random
{
    private:
        std::random_device m_device;
        std::default_random_engine m_engine;

    public:
        Random()
            : m_device(std::random_device())
            , m_engine(m_device())
        {
        }

        double uniform(double begin = 0.0, double end = 1.0)
        {
            std::uniform_real_distribution<double> distribution(begin, end);
            return distribution(m_engine);
        }
};

#endif

