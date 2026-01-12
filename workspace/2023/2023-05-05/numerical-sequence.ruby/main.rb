
def main()
    puts 'factorials:'
    puts (1..10).map(&method(:factorial)).join(' ')

    puts 'fibonacci numbers:'
    puts (0..20).map(&method(:fibonacci)).join(' ')

    puts 'FizzBuzz values:'
    puts (1..100).map(&method(:fizzbuzz)).join(' ')
end

def factorial(n)
    if n == 0
        1
    else
        n * factorial(n - 1)
    end
end

def fibonacci(n)
    if n == 0 || n == 1
        n
    else
        fibonacci(n - 1) + fibonacci(n - 2)
    end
end

def fizzbuzz(n)
    if n % 15 == 0
        :FizzBuzz
    elsif n % 5 == 0
        :Buzz
    elsif n % 3 == 0
        :Fizz
    else
        n
    end
end

main

