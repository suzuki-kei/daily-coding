
const MIN = 10
const MAX = 99

function main()
{
    const array = generate_random_values(MIN, MAX, 20)
    print_array(array)
    heap_sort(array)
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

function heap_sort(array)
{
    heap_build(array)
    heap_pop_all(array)
}

function heap_build(array)
{
    for (let i = Math.floor(array.length / 2) - 1; i >= 0; i--)
        heap_shift_down(array, array.length, i)
}

function heap_pop_all(array)
{
    for (let i = array.length - 1; i >= 1; i--)
    {
        swap(array, i, 0)
        heap_shift_down(array, i, 0)
    }
}

function heap_shift_down(array, n, i)
{
    while (i * 2 + 1 < n)
    {
        let maximum_index = i
        const left_index = i * 2 + 1
        const right_index = i * 2 + 2

        if (left_index < n && array[left_index] > array[maximum_index])
            maximum_index = left_index

        if (right_index < n && array[right_index] > array[maximum_index])
            maximum_index = right_index

        if (maximum_index === i)
            break

        swap(array, i, maximum_index)
        i = maximum_index
    }
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

