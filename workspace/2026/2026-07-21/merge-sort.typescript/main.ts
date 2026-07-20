
function main(): void
{
    const array = generate_random_values(20)
    print_array(array)
    merge_sort(array)
    print_array(array)
}

function generate_random_values(n: number): number[]
{
    return new_array(n, _ => random_range(10, 99))
}

function new_array<T>(n: number, f: (i: number) => T): T[]
{
    return Array.from({length: n}, f)
}

function random_range(min: number, max: number): number
{
    return Math.floor(Math.random() * (max - min + 1)) + min
}

function print_array(array: readonly number[]): void
{
    if (is_sorted(array))
        console.log(`${array.join(" ")} (sorted)`)
    else
        console.log(`${array.join(" ")} (not sorted)`)
}

function is_sorted(array: readonly number[]): boolean
{
    for (let i = 0; i + 1 < array.length; i++)
        if (array[i] > array[i + 1])
            return false

    return true
}

function merge_sort(array: number[]): void
{
    const buffer = new_array(array.length, () => 0)
    let input = array
    let output = buffer

    for (let chunk_size = 1; chunk_size < array.length; chunk_size *= 2)
    {
        for (let i = 0; i + chunk_size < array.length; i += chunk_size * 2)
        {
            merge(
                output,
                i,
                input,
                i,
                Math.min(array.length, i + chunk_size),
                Math.min(array.length, i + chunk_size),
                Math.min(array.length, i + chunk_size * 2))
        }

        [input, output] = [output, input]
    }

    if (array === output)
        for (let i = 0; i < array.length; i++)
            array[i] = buffer[i]
}

function merge(
        output: number[],
        output_index: number,
        input: readonly number[],
        begin1: number,
        end1: number,
        begin2: number,
        end2: number)
{
    while (begin1 < end1 && begin2 < end2)
    {
        if (input[begin1] <= input[begin2])
            output[output_index++] = input[begin1++]
        else
            output[output_index++] = input[begin2++]
    }

    while (begin1 < end1)
        output[output_index++] = input[begin1++]

    while (begin2 < end2)
        output[output_index++] = input[begin2++]
}

main()

