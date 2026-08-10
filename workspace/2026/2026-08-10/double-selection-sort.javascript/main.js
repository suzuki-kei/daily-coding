
const MIN = 10
const MAX = 99

function main()
{
    const array = generate_random_values(MIN, MAX, 20)
    print_array(array)
    double_selection_sort(array)
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

function double_selection_sort(array)
{
    for (let first = 0, last = array.length - 1; first < last; first++, last--)
    {
        let minimum_index = first
        let maximum_index = first

        for (let i = first; i <= last; i++)
            if (array[i] < array[minimum_index])
                minimum_index = i
            else if (array[i] > array[maximum_index])
                maximum_index = i

        swap(array, first, minimum_index)

        if (first === maximum_index)
            maximum_index = minimum_index

        swap(array, last, maximum_index)
    }
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

