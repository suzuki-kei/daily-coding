
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
    if n == 0
        1
    else
        n * factorial(n - 1)
    end
end

def fibonacci(n)
    if n == 0
        0
    elsif n == 1
        1
    else
        fibonacci(n - 1) + fibonacci(n - 2)
    end
end

def fizz_buzz(n)
    if n % 15 == 0
        'FizzBuzz'
    elsif n % 5 == 0
        'Buzz'
    elsif n % 3 == 0
        'Fizz'
    else
        n.to_s
    end
end

main

