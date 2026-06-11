
function main()
{
    const array = generate_random_values(20)
    print_array(array)
    shaker_sort(array)
    print_array(array)
}

function generate_random_values(n)
{
    return [...Array(n)].map(
        _ => random_range(10, 99)
    )
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
    if (array.length <= 1)
        return true

    return [...Array(array.length - 1).keys()].every(
        i => array[i] <= array[i + 1]
    )
}

function shaker_sort(array)
{
    let lower = 0
    let upper = array.length - 1

    while (lower < upper)
    {
        for (let i = lower; i + 1 <= upper; i++)
            if (array[i] > array[i + 1])
                swap(array, i, i + 1)
        upper--

        for (let i = upper; i - 1 >= lower; i--)
            if (array[i] < array[i - 1])
                swap(array, i, i - 1)
        lower++
    }
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

