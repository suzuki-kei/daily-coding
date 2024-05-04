
function main()
{
    const values = generate_random_values(20)
    print_array(values)
    bubble_sort(values)
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

function bubble_sort(values)
{
    for (let unsorted_size = values.length; unsorted_size > 0; unsorted_size--)
        for (let i = 0; i < unsorted_size - 1; i++)
            if (values[i] > values[i + 1])
                swap(values, i, i + 1)
}

function swap(values, index1, index2)
{
    const value1 = values[index1]
    values[index1] = values[index2]
    values[index2] = value1
}

main()

