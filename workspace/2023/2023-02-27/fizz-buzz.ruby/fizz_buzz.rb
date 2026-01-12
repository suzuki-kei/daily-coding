
def main
    puts fizz_buzz(100)
end

def fizz_buzz(n)
    (1..n).map do |i|
        fizz_buzz_value(i)
    end
end

def fizz_buzz_value(i)
    case
        when i % 15 == 0
            'FizzBuzz'
        when i % 5 == 0
            'Buzz'
        when i % 3 == 0
            'Fizz'
        else
            i
    end
end

main

