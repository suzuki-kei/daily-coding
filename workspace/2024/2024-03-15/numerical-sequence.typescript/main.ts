
function main()
{
    print_sequence("factorials", factorial, 1, 10)
    print_sequence("fibonacci numbers", fibonacci, 0, 20)
    print_sequence("fizz buzz values", fizz_buzz, 1, 100)
}

function print_sequence(description: string, f: (n: number) => number|string, min: number, max: number)
{
    console.log(`${description}:`)
    console.log(sequence(min, max).map(f).join(" "))
}

function sequence(min: number, max: number): number[]
{
    return [...Array(max - min + 1).keys()].map(x => x + min)
}

function factorial(n: number): number
{
    if (n == 0)
        return 1
    return n * factorial(n - 1)
}

function fibonacci(n: number): number
{
    if (n == 0)
        return 0
    if (n == 1)
        return 1
    return fibonacci(n - 1) + fibonacci(n - 2)
}

function fizz_buzz(n: number): string
{
    if (n % 15 == 0)
        return "FizzBuzz"
    if (n % 5 == 0)
        return "Buzz"
    if (n % 3 == 0)
        return "Fizz"
    return String(n)
}

main()

