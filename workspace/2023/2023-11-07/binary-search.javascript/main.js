
function main()
{
    let values = generate_random_ascending_values(20)
    console.log(values.join(" "))

    let lower = values[0] - 1
    let upper = values[values.length - 1] + 1

    for (var target = lower; target <= upper; target++)
    {
        let index = binary_search(values, target)
        console.log(`target=${target}, index=${index}`)
    }
}

function generate_random_ascending_values(n)
{
    var offset = 10
    let values = []

    for (var i = 0; i < n; i++)
    {
        let value = Math.floor(Math.random() * 5) + offset
        values.push(value)
        offset = value + 1
    }

    return values
}

function binary_search(values, target)
{
    return binary_search_range(values, 0, values.length - 1, target)
}

function binary_search_range(values, lower, upper, target)
{
    let center = (lower + upper) // 2

    if (center < lower || upper < center)
        return -1
    if (target < values[center])
        return binary_search_range(values, lower, center - 1, target)
    if (target > values[center])
        return binary_search_range(values, center + 1, upper, target)
    return center
}

main()

