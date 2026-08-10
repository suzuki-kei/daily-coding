
const MIN = 0
const MAX = 9

function main()
{
    const array = generate_random_values(MIN, MAX, 20)
    print_array(array)
    distribution_counting_sort(array, MIN, MAX)
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

function distribution_counting_sort(array, min, max)
{
    const n_counts = max - min + 1
    const counts = Array.from({length: n_counts}, () => 0)
    const buffer = Array.from(array)

    for (let i = 0; i < array.length; i++)
        counts[array[i] - min]++

    for (let i = 1; i < n_counts; i++)
        counts[i] += counts[i - 1]

    for (let i = array.length - 1; i >= 0; i--)
        buffer[--counts[array[i] - min]] = array[i]

    for (let i = 0; i < array.length; i++)
        array[i] = buffer[i]
}

main()

