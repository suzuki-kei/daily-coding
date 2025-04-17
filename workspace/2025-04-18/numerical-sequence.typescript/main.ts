
function main(): void
{
    print_sequence("factorials", factorial, 1, 10)
    print_sequence("fibonacci numbers", fibonacci, 0, 20)
    print_sequence("fizz buzz values", fizz_buzz, 1, 100)
}

function print_sequence<T>(description: string, f: (n: number) => T, min: number, max: number): void
{
    const values = sequence(min, max).map(f)
    const string = values.join(" ")

    console.log(`${description}:`)
    console.log(`${string}`)
}

function sequence(min: number, max: number): number[]
{
    return [...Array(max - min + 1).keys()]
}

function factorial(n: number): number
{
    function accumulate(n: number, fm: number): number
    {
        if (n === 0)
            return fm
        return accumulate(n - 1, fm * n)
    }

    return accumulate(n, 1)
}

function fibonacci(n: number): number
{
    function accumulate(n: number, a: number, b: number): number
    {
        if (n === 0)
            return a
        return accumulate(n - 1, b, a + b)
    }

    return accumulate(n, 0, 1)
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

