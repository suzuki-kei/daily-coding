
function main()
{
    const array = generate_random_values(20)
    print_array(array)
    bubble_sort(array)
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

function bubble_sort(array, partition)
{
    for (let unsorted_length = array.length; unsorted_length >= 0; unsorted_length--)
        for (let i = 0; i < unsorted_length - 1; i++)
            if (array[i] > array[i + 1])
                swap(array, i, i + 1)
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

