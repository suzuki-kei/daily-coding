#ifndef INTEGER_HPP_INCLUDED
#define INTEGER_HPP_INCLUDED

#include <iostream>

class Integer
{
public:
    static bool TRACE;

private:
    const int m_value;

public:
    Integer(int value)
        : m_value(value)
    {
        if (TRACE)
            std::cout << "(Integer:" << this << ") " << "constructor called." << std::endl;
    }

    Integer(const Integer &integer)
        : m_value(integer.m_value)
    {
        if (TRACE)
            std::cout << "(Integer:" << this << ") " << "copy constructor called." << std::endl;
    }

    virtual ~Integer()
    {
        if (TRACE)
            std::cout << "(Integer:" << this << ") " << "destructor called." << std::endl;
    }

    virtual int value() const
    {
        return m_value;
    }
};

bool Integer::TRACE = false;

std::ostream &operator<<(std::ostream &stream, const Integer &integer)
{
    stream << integer.value();
    return stream;
}

#endif

