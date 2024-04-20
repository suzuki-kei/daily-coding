
function main(): void
{
    print_sequence("factorials", factorial, 1, 10)
    print_sequence("fibonacci numbers", fibonacci, 0, 20)
    print_sequence("fizz buzz values", fizz_buzz, 1, 100)
}

function print_sequence<T>(description: string, f: (n: number) => T, min: number, max: number): void
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
    return factorial_tailrec(n, 1)
}

function factorial_tailrec(n: number, accumulated: number): number
{
    if (n === 0)
        return accumulated
    return factorial_tailrec(n - 1, accumulated * n)
}

function fibonacci(n: number): number
{
    return fibonacci_tailrec(n, 0, 1)
}

function fibonacci_tailrec(n: number, a: number, b: number): number
{
    if (n === 0)
        return a
    return fibonacci_tailrec(n - 1, b, a + b)
}

function fizz_buzz(n: number): string
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

