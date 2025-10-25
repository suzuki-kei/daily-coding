
function main(): void
{
    const values = generateRandomAscendingValues(20)
    console.log(values.join(" "))

    const lower = checkedAt(values, 0) - 1
    const upper = checkedAt(values, -1) + 1

    for (let target = lower; target <= upper; target++)
    {
        const index = binarySearch(values, target)
        console.log(`target=${target}, index=${index}`)
    }
}

function generateRandomAscendingValues(n: number): number[]
{
    let value = 9
    const values = []

    for (let i = 0; i < n; i++)
    {
        value += Math.floor(Math.random() * 5) + 1
        values.push(value)
    }

    return values
}

function checkedAt<T>(values: readonly T[], index: number): T
{
    const value = values.at(index)

    if (value === undefined)
        throw new Error(`values.at(${index}) is undefined.`)

    return value
}

function binarySearch<T>(values: readonly T[], target: T, lower?: number, upper?: number): number
{
    lower ??= 0
    upper ??= values.length - 1

    if (lower > upper)
        return -1

    const center = Math.floor((lower + upper) / 2)

    if (target === values[center])
        return center

    if (target < values[center])
        return binarySearch(values, target, lower, center - 1)
    else
        return binarySearch(values, target, center + 1, upper)
}

main()

