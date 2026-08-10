
const MIN = 10
const MAX = 99

function main()
{
    const array = generate_random_values(MIN, MAX, 20)
    print_array(array)
    shell_sort(array)
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

function shell_sort(array)
{
    for (let gap = compute_initial_gap(array.length); gap >= 1; gap = Math.floor(gap / 3))
        for (let i = gap; i < array.length; i++)
            insert(array, i, gap)
}

function compute_initial_gap(n)
{
    let gap = 1

    while (gap * 3 + 1 < n)
        gap = gap * 3 + 1

    return gap
}

function insert(array, i, gap)
{
    const value = array[i]

    while (i >= gap && value < array[i - gap])
    {
        array[i] = array[i - gap]
        i -= gap
    }

    array[i] = value
}

main()

