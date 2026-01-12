
function main()
{
    let values = generate_random_values(20)
    console.log(values.join(" "))
    quick_sort(values)
    console.log(values.join(" "))
}

function generate_random_values(n)
{
    return Array.from(Array(n)).map(_ => Math.floor(Math.random() * 90 + 10))
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
        {
            [values[lower_index], values[upper_index]] = [values[upper_index], values[lower_index]]
            lower_index++
            upper_index--
        }
    }

    if (lower < upper_index)
        quick_sort_range(values, lower, upper_index)
    if (lower_index < upper)
        quick_sort_range(values, lower_index, upper)
}

main()

