
const MIN = 10
const MAX = 99

function main()
{
    const array = generate_random_values(MIN, MAX, 20)
    print_array(array)
    insertion_sort(array)
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

function insertion_sort(array)
{
    for (let i = 1; i < array.length; i++)
        insert(array, i)
}

function insert(array, i)
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

