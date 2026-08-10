
const MIN = 10
const MAX = 99

function main()
{
    const array = generate_random_values(MIN, MAX, 20)
    print_array(array)
    merge_sort(array)
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

function merge_sort(array)
{
    const buffer = Array.from(array)
    let input = array
    let output = buffer

    for (let chunk_size = 1; chunk_size < array.length; chunk_size *= 2)
    {
        for (let i = 0; i < array.length; i += chunk_size * 2)
        {
            merge(
                output,
                i,
                input,
                i,
                Math.min(array.length, i + chunk_size),
                Math.min(array.length, i + chunk_size),
                Math.min(array.length, i + chunk_size * 2));
        }

        [input, output] = [output, input]
    }

    if (array == output)
        for (let i = 0; i < array.length; i++)
            array[i] = buffer[i]
}

function merge(output, output_index, input, begin1, end1, begin2, end2)
{
    while (begin1 < end1 && begin2 < end2)
        if (input[begin1] <= input[begin2])
            output[output_index++] = input[begin1++]
        else
            output[output_index++] = input[begin2++]

    while (begin1 < end1)
        output[output_index++] = input[begin1++]

    while (begin2 < end2)
        output[output_index++] = input[begin2++]
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

