
function main(): void
{
    const array = generate_random_values(20)
    print_array(array)
    heap_sort(array)
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

function heap_sort(array: number[]): void
{
    make_heap(array)
    pop_all(array)
}

function make_heap(array: number[]): void
{
    for (let i = array.length / 2 - 1; i >= 0; i--)
        shift_down(array, array.length, i)
}

function pop_all(array: number[]): void
{
    for (let i = array.length - 1; i >= 1; i--)
    {
        swap(array, i, 0)
        shift_down(array, i, 0)
    }
}

function shift_down(array: number[], n: number, i: number): void
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

        if (i === maximum_index)
            break

        swap(array, i, maximum_index)
        i = maximum_index
    }
}

function swap<T>(array: T[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

