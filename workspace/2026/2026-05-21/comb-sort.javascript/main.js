
function main()
{
    const array = generate_random_values(20)
    print_array(array)
    comb_sort(array)
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

function comb_sort(array)
{
    let gap = array.length
    let done = false

    while (!done)
    {
        gap = compute_next_gap(gap)
        done = true

        for (let i = 0; i + gap < array.length; i++)
        {
            if (array[i] > array[i + gap])
            {
                swap(array, i, i + gap)
                done = gap === 1
            }
        }
    }
}

function compute_next_gap(gap)
{
    if (gap <= 2)
        return 1

    if (gap === 9 || gap === 10)
        return 11

    return Math.floor(gap * 10 / 13)
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

