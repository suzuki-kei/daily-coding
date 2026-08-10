
const MIN = 10
const MAX = 99

function main()
{
    demonstration("partition 2-way", partition_2way)
    demonstration("partition 3-way", partition_3way)
}

function demonstration(label, partition)
{
    console.log(`==== ${label}`)
    const array = generate_random_values(MIN, MAX, 20)
    print_array(array)
    quick_sort(array, partition)
    print_array(array)
}

function generate_random_values(min, max, n)
{
    return Array.from({length: n}, () => random_range(min, max))
}

function random_range(min, max)
{
    return Math.floor(Math.random() * (max - min + 1)) + min
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
    for (let i = 0; i + 1 < array.length; i++)
        if (array[i] > array[i + 1])
            return false

    return true
}

function quick_sort(array, partition)
{
    quick_sort_range(array, 0, array.length - 1, partition)
}

function quick_sort_range(array, first, last, partition)
{
    while (first < last)
    {
        const result = partition(array, first, last)
        const n_left = result.left_last - first + 1
        const n_right = last - result.right_first + 1

        if (n_left <= n_right)
        {
            quick_sort_range(array, first, result.left_last, partition)
            first = result.right_first
        }
        else
        {
            quick_sort_range(array, result.right_first, last, partition)
            last = result.left_last
        }
    }
}

function partition_2way(array, first, last)
{
    let increment_index = first
    let decrement_index = last
    const pivot = array[random_range(first, last)]

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
        left_last: decrement_index,
        right_first: increment_index,
    }
}

function partition_3way(array, first, last)
{
    let less_end = first
    let increment_index = first
    let decrement_index = last
    const pivot = array[random_range(first, last)]

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
        left_last: less_end - 1,
        right_first: increment_index,
    }
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

