
function main(): void
{
    const values = generate_random_ascending_values(20)
    console.log(values.join(" "))

    const lower = values.at(0) - 1
    const upper = values.at(-1) + 1

    for (let target = lower; target <= upper; target++)
    {
        const index = binary_search(values, target)
        console.log(`target=${target}, index=${index}`)
    }
}

function generate_random_ascending_values(n: number): number[]
{
    const values = []

    for (let i = 0; i < n; i++)
    {
        const offset = (values.at(-1) || 9) + 1
        const value = Math.floor(Math.random() * 5 + offset)
        values.push(value)
    }

    return values
}

function binary_search<T>(values: T[], target: T): number
{
    return binary_search_range(values, target, 0, values.length - 1)
}

function binary_search_range<T>(values: T[], target: T, lower: number, upper: number): number
{
    if (lower > upper)
        return -1

    const center = Math.floor((lower + upper) / 2)

    if (target < values[center])
        return binary_search_range(values, target, lower, center - 1)
    if (target > values[center])
        return binary_search_range(values, target, center + 1, upper)
    return center
}

main()

