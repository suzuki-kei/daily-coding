
function main()
{
    const array = generate_random_values(20)
    print_array(array)
    selection_sort(array)
    print_array(array)
}

function generate_random_values(n)
{
    return [...Array(n)].map(
        _ => Math.floor(Math.random() * 90) + 10
    )
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

function selection_sort(array)
{
    for (let begin = 0; begin < array.length; begin++)
    {
        let minimum_index = begin

        for (let i = begin + 1; i < array.length; i++)
            if (array[i] < array[minimum_index])
                minimum_index = i

        swap(array, begin, minimum_index)
    }
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

