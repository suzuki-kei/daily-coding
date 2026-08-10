
const MIN = 10
const MAX = 99

function main()
{
    const array = generate_random_values(MIN, MAX, 20)
    print_array(array)
    comb_sort(array)
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

function comb_sort(array)
{
    let gap = array.length
    let swapped = false

    do
    {
        gap = compute_next_gap(gap)
        swapped = false

        for (let i = 0; i + gap < array.length; i++)
        {
            if (array[i] > array[i + gap])
            {
                swap(array, i, i + gap)
                swapped = true
            }
        }
    }
    while (gap > 1 || swapped)
}

function compute_next_gap(gap)
{
    if (gap <= 2)
        return 1

    if (13 <= gap && gap <= 15)
        return 11

    return Math.floor(gap * 10 / 13)
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

