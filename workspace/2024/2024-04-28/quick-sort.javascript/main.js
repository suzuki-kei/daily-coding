
function main()
{
    const values = generate_random_values(20)
    print_array(values)
    quick_sort(values)
    print_array(values)
}

function generate_random_values(n)
{
    const values = []

    for (let i = 0; i < n; i++)
        values.push(Math.floor(Math.random() * 90 + 10))

    return values
}

function print_array(values)
{
    if (is_sorted(values))
        console.log(`${values.join(" ")} (sorted)`)
    else
        console.log(`${values.join(" ")} (not sorted)`)
}

function is_sorted(values)
{
    for (let i = 0; i < values.length - 1; i++)
        if (values[i] > values[i + 1])
            return false
    return true
}

function quick_sort(values)
{
    quick_sort_range(values, 0, values.length - 1)
}

function quick_sort_range(values, lower, upper)
{
    let lower_index = lower
    let upper_index = upper
    const pivot = values[Math.floor((lower + upper) / 2)]

    while (lower_index <= upper_index)
    {
        while (values[lower_index] < pivot)
            lower_index++
        while (values[upper_index] > pivot)
            upper_index--
        if (lower_index <= upper_index)
            swap(values, lower_index++, upper_index--)
    }

    if (lower < upper_index)
        quick_sort_range(values, lower, upper_index)
    if (lower_index < upper)
        quick_sort_range(values, lower_index, upper)
}

function swap(values, index1, index2)
{
    const value1 = values[index1]
    values[index1] = values[index2]
    values[index2] = value1
}

main()

