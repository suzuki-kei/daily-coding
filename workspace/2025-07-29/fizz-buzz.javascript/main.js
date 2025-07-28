
function main()
{
    console.log([...generate_fizz_buzz_values(100)].join(" "))
}

function *generate_fizz_buzz_values(n)
{
    const tuples = zip(cycle([...Array(14), "FizzBuzz"]),
                       cycle([...Array( 4), "Buzz"]),
                       cycle([...Array( 2), "Fizz"]),
                       count(1, {step: 1}))
    const values = map(coalesce, tuples)
    yield *take(n, values)
}

function *cycle(values)
{
    for (;;)
        for (const value of values)
            yield value
}

function *count(start, {step = 1} = {})
{
    for (let n = start; true; n += step)
        yield n
}

function *zip(...generators)
{
    while (!generators.every(generator => generator.done))
        yield generators.map(generator => generator.next().value)
}

function *map(f, generator)
{
    while (!generator.done)
        yield f(generator.next().value)
}

function coalesce(values)
{
    for (const value of values)
        if (value !== undefined)
            return value

    return undefined
}

function *take(n, generator)
{
    for (let i = 0; i < n; i++)
        yield generator.next().value
}

main()

