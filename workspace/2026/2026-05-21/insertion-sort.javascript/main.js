
function main()
{
    const array = generate_random_values(20)
    print_array(array)
    insertion_sort(array)
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

function insertion_sort(array)
{
    for (let i = 1; i < array.length; i++)
        insert(array, i)
}

function insert(array, i, n)
{
    const value = array[i]

    while (i >= 1 && value < array[i - 1])
    {
        array[i] = array[i - 1]
        i--
    }

    array[i] = value
}

main()

