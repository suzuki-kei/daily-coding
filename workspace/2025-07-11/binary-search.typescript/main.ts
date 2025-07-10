
function main(): void
{
    const values = generate_random_ascending_values(20)
    console.log(values.join(" "))

    const lower = getFromArray(values, 0) - 1
    const upper = getFromArray(values, -1) + 1

    for (let target = lower; target <= upper; target++)
    {
        const index = binary_search(values, target)
        console.log(`target=${target}, index=${index}`)
    }
}

function generate_random_ascending_values(n: number): number[]
{
    const values: number[] = []

    for (let i = 0; i < n; i++)
    {
        const offset = getFromArray(values, -1, 9) + 1
        values.push(Math.floor(Math.random() * 5) + offset)
    }

    return values
}

function getFromArray<T>(values: T[], index: number, defaultValue?: T): T
{
    const value = values.at(index) || defaultValue

    if (value === undefined)
        throw new Error(`values.at(${index}) is undefined.`)

    return value
}

function binary_search(values: number[], target: number): number
{
    return binary_search_range(values, target, 0, values.length - 1)
}

function binary_search_range(values: number[], target: number, lower: number, upper: number): number
{
    if (lower > upper)
        return -1

    const center = Math.floor((lower + upper) / 2)

    if (target === values[center])
        return center

    if (target < values[center])
        return binary_search_range(values, target, lower, center - 1)
    else
        return binary_search_range(values, target, center + 1, upper)
}

main()

