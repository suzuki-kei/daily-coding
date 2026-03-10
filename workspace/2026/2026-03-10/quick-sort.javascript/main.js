
function main()
{
    demonstration("partition 2-way", partition_2way)
    demonstration("partition 3-way", partition_3way)
}

function demonstration(label, partition)
{
    console.log(`==== ${label}`)

    const array = generate_random_values(20)
    print_array(array)
    quick_sort(array, partition)
    print_array(array)
}

function generate_random_values(n)
{
    return [...Array(n)].map(
        _ => Math.floor(Math.random() * 90) + 10
    )
}

function print_array(array)
{
    if (is_sorted(array))
        console.log(`${array.join(" ")} (sorted)`)
    else
        console.log(`${array.join(" ")} (not sorted)`)
}

function is_sorted(array)
{
    if (array.length <= 1)
        return true

    return [...Array(array.length - 1).keys()].every(
        i => array[i] <= array[i + 1]
    )
}

function quick_sort(array, partition)
{
    if (array.length <= 1)
        return

    quick_sort_range(array, 0, array.length - 1, partition)
}

function quick_sort_range(array, lower, upper, partition)
{
    if (lower >= upper)
        return

    const result = partition(array, lower, upper)
    quick_sort_range(array, lower, result.left_upper, partition)
    quick_sort_range(array, result.right_lower, upper, partition)
}

function partition_2way(array, lower, upper)
{
    let increment_index = lower
    let decrement_index = upper
    const pivot = random_select(array, lower, upper)

    while (increment_index <= decrement_index)
    {
        while (array[increment_index] < pivot)
            increment_index++
        while (array[decrement_index] > pivot)
            decrement_index--
        if (increment_index <= decrement_index)
            swap(array, increment_index++, decrement_index--)
    }

    return {
        left_upper: decrement_index,
        right_lower: increment_index,
    }
}

function partition_3way(array, lower, upper)
{
    let less_end = lower
    let increment_index = lower
    let decrement_index = upper
    const pivot = random_select(array, lower, upper)

    while (increment_index <= decrement_index)
    {
        if (array[increment_index] < pivot)
            swap(array, less_end++, increment_index++)
        else if (array[increment_index] > pivot)
            swap(array, increment_index, decrement_index--)
        else
            increment_index++
    }

    return {
        left_upper: less_end - 1,
        right_lower: increment_index,
    }
}

function random_select(array, lower, upper)
{
    return array[Math.floor(Math.random() * (upper - lower + 1)) + lower]
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

