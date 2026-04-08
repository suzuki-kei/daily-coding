
function main(): void
{
    const array = generate_random_values(20)
    print_array(array)
    bubble_sort(array)
    print_array(array)
}

function generate_random_values(n: number): number[]
{
    return [...Array(n)].map(
        _ => Math.floor(Math.random() * 90) + 10
    )
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
    if (array.length <= 1)
        return true

    return [...Array(array.length - 1).keys()].every(
        i => array[i] <= array[i + 1]
    )
}

function bubble_sort(array: number[]): void
{
    for (let end = array.length; 1 <= end; end--)
        for (let i = 0; i < end - 1; i++)
            if (array[i] > array[i + 1])
                swap(array, i, i + 1)
}

function swap<T>(array: T[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

