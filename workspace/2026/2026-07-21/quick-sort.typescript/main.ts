
type PartitionResult = {
    left_last: number,
    right_first: number,
}

type Partition = (
    array: number[],
    first: number,
    last: number,
) => PartitionResult

function main(): void
{
    demonstration("partition 2-way", partition_2way)
    demonstration("partition 3-way", partition_3way)
}

function demonstration(label: string, partition: Partition): void
{
    console.log(`==== ${label}`)

    const array = generate_random_values(20)
    print_array(array)
    quick_sort(array, partition)
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

function quick_sort(array: number[], partition: Partition): void
{
    quick_sort_range(array, 0, array.length - 1, partition)
}

function quick_sort_range(array: number[], first: number, last: number, partition: Partition): void
{
    while (first < last)
    {
        const result = partition(array, first, last)
        const left_size = result.left_last - first + 1
        const right_size = last - result.right_first + 1

        if (left_size <= right_size)
        {
            quick_sort_range(array, first, result.left_last, partition)
            first = result.right_first
        }
        else
        {
            quick_sort_range(array, result.right_first, last, partition)
            last = result.left_last
        }
    }
}

function partition_2way(array: number[], first: number, last: number): PartitionResult
{
    let increment_index = first
    let decrement_index = last
    const pivot = array[random_range(first, last)]

    while (increment_index <= decrement_index)
    {
        while (array[increment_index] < pivot)
            increment_index++

        while (array[decrement_index] > pivot)
            decrement_index--

        if (increment_index <= decrement_index)
            swap(array, increment_index++, decrement_index--)
    }

    return {
        left_last: decrement_index,
        right_first: increment_index,
    }
}

function partition_3way(array: number[], first: number, last: number): PartitionResult
{
    let less_end = first
    let increment_index = first
    let decrement_index = last
    const pivot = array[random_range(first, last)]

    while (increment_index <= decrement_index)
    {
        if (array[increment_index] < pivot)
            swap(array, less_end++, increment_index++)
        else if (array[increment_index] > pivot)
            swap(array, increment_index, decrement_index--)
        else
            increment_index++
    }

    return {
        left_last: less_end - 1,
        right_first: increment_index,
    }
}

function swap<T>(array: T[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

