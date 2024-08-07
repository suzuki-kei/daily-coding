
function main()
{
    print_sequence("factorials", factorial, 1, 10)
    print_sequence("fibonacci numbers", fibonacci, 0, 20)
    print_sequence("fizz buzz values", fizz_buzz, 1, 100)
}

function print_sequence(description, f, min, max)
{
    const values = sequence(min, max).map(f)
    const string = values.join(" ")

    console.log(`${description}:`)
    console.log(string)
}

function sequence(min, max)
{
    return [...Array(max - min + 1).keys()].map(x => x + min)
}

function factorial(n)
{
    return factorial_tailrec(n, 1)
}

function factorial_tailrec(n, accumulated)
{
    if (n === 0)
        return accumulated
    return factorial_tailrec(n - 1, accumulated * n)
}

function fibonacci(n)
{
    return fibonacci_tailrec(n, 0, 1)
}

function fibonacci_tailrec(n, a, b)
{
    if (n === 0)
        return a
    return fibonacci_tailrec(n - 1, b, a + b)
}

function fizz_buzz(n)
{
    if (n % 15 === 0)
        return "FizzBuzz"
    if (n % 5 === 0)
        return "Buzz"
    if (n % 3 === 0)
        return "Fizz"
    return String(n)
}

main()

