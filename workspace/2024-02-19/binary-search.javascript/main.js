
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
    return Array.from(Array(n)).reduce((values, _) => {
        const offset = (values.at(-1) || 9) + 1
        const value = Math.floor(Math.random() * 5 + offset)
        values.push(value)
        return values
    }, [])
}

function binary_search(values, target)
{
    return binary_search_range(values, target, 0, values.length - 1)
}

function binary_search_range(values, target, lower, upper)
{
    const center = Math.floor((lower + upper) / 2)

    if (center < lower || upper < center)
        return -1
    if (target < values[center])
        return binary_search_range(values, target, lower, center - 1)
    if (target > values[center])
        return binary_search_range(values, target, center + 1, upper)
    return center
}

main()

