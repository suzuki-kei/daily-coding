
function main()
{
    print_sequence("factorials", factorial, 1, 10)
    print_sequence("fibonacci numbers", fibonacci, 0, 20)
    print_sequence("fizz buzz values", fizz_buzz, 1, 100)
}

function print_sequence(description, f, min, max)
{
    console.log(`${description}:`)
    console.log(sequence(min, max).map(f).join(" "))
}

function sequence(min, max)
{
    return Array.from(Array(max - min + 1).keys()).map(x => x + min)
}

function factorial(n)
{
    return factorial_tailrec(n, 1)
}

function factorial_tailrec(n, accumulated)
{
    if (n === 0)
        return accumulated
    return factorial_tailrec(n - 1, n * accumulated)
}

function fibonacci(n)
{
    return fibonacci_tailrec(0, 1, n)
}

function fibonacci_tailrec(a, b, n)
{
    if (n === 0)
        return a
    return fibonacci_tailrec(b, a + b, n - 1)
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

