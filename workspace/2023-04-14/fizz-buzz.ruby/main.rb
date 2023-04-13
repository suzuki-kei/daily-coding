
def main
    puts (1..100).map(&method(:fizz_buzz))
end

def fizz_buzz(n)
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

