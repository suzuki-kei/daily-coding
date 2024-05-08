
def main
    print_sequence('factorials', method(:factorial), 1, 10)
    print_sequence('fibonacci numbers', method(:fibonacci), 0, 20)
    print_sequence('fizz buzz values', method(:fizz_buzz), 1, 100)
end

def print_sequence(description, f, min, max)
    puts "#{description}:"
    puts (min..max).map(&f).join(' ')
end

def factorial(n, accumulated=1)
    case n
        when 0
            accumulated
        else
            factorial(n - 1, accumulated * n)
    end
end

def fibonacci(n, a=0, b=1)
    case n
        when 0
            a
        else
            fibonacci(n - 1, b, a + b)
    end
end

def fizz_buzz(n)
    case [n % 5 == 0, n % 3 == 0]
        when [true, true]
            'FizzBuzz'
        when [true, false]
            'Buzz'
        when [false, true]
            'Fizz'
        else
            n
    end
end

main if $0 == __FILE__

