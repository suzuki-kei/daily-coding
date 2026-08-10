
const MIN = 10
const MAX = 99

function main()
{
    const array = generate_random_values(MIN, MAX, 20)
    print_array(array)
    shaker_sort(array)
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

function shaker_sort(array)
{
    let first = 0
    let last = array.length - 1

    while (first < last)
    {
        for (let i = first; i + 1 <= last; i++)
            if (array[i] > array[i + 1])
                swap(array, i, i + 1)
        last--

        for (let i = last; i - 1 >= first; i--)
            if (array[i] < array[i - 1])
                swap(array, i, i - 1)
        first++
    }
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

