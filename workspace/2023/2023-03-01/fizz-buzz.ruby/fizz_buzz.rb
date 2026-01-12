
def main
    puts fizz_buzz(100)
end

def fizz_buzz(n)
    (1..n).map do |i|
        fizz_buzz_value(i)
    end
end

def fizz_buzz_value(n)
    case
        when n % 15 == 0
            :FizzBuzz
        when n % 5 == 0
            :Buzz
        when n % 3 == 0
            :Fizz
        else
            n
    end
end

main

