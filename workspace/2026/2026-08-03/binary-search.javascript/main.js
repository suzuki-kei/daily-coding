
function main()
{
    const values = selection_without_replacement(10, 99, 20)
    console.log(values.join(" "))

    const min = values.at(0) - 1
    const max = values.at(-1) + 1

    for (let target = min; target <= max; target++)
    {
        const index = binary_search(values, target)
        console.log(`target=${target}, index=${index}`)
    }
}

function selection_without_replacement(min, max, n)
{
    const values = []

    for (let value = min; value <= max; value++)
    {
        const numerator = n - values.length
        const denominator = max - value + 1
        const r = Math.random()

        if (r < numerator / denominator)
            values.push(value)
    }

    return values
}

function binary_search(values, target, first, last)
{
    first ??= 0
    last ??= values.length - 1

    if (first > last)
        return -1

    const center = Math.floor((first + last) / 2)

    if (target === values[center])
        return center

    if (target < values[center])
        return binary_search(values, target, first, center - 1)
    else
        return binary_search(values, target, center + 1, last)
}

main()

