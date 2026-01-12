
function main()
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

function generate_random_ascending_values(n)
{
    const values = []

    for (let i = 0; i < n; i++)
    {
        const offset = (values.at(-1) || 9) + 1
        values.push(Math.floor(Math.random() * 5) + offset)
    }

    return values
}

function binary_search(values, target, lower, upper)
{
    lower ??= 0
    upper ??= values.length - 1

    if (lower > upper)
        return -1

    const center = Math.floor((lower + upper) / 2)

    if (target === values[center])
        return center

    if (target < values[center])
        return binary_search(values, target, lower, center - 1)
    else
        return binary_search(values, target, center + 1, upper)
}

main()

