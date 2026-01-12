
def main
    puts 'factorials:'
    puts (1..10).map(&method(:factorial)).join(' ')

    puts 'fibonacci numbers:'
    puts (0..20).map(&method(:fibonacci)).join(' ')

    puts 'fizz buzz values:'
    puts (1..100).map(&method(:fizz_buzz)).join(' ')
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
        when 0, 1
            n
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

