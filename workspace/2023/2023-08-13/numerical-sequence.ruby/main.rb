
def main
    print_sequence('factorials', method(:factorial), 1, 10)
    print_sequence('fibonacci numbers', method(:fibonacci), 0, 20)
    print_sequence('fizz buzz values', method(:fizz_buzz), 1, 100)
end

def print_sequence(description, f, min, max)
    puts "#{description}:"
    puts (min..max).map(&f).join(' ')
end

def factorial(n)
    case n
        when 0
            1
        else
            n * factorial(n - 1)
    end
end

def fibonacci(n)
    case n
        when 0
            0
        when 1
            1
        else
            fibonacci(n - 1) + fibonacci(n - 2)
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
            n.to_s
    end
end

main

