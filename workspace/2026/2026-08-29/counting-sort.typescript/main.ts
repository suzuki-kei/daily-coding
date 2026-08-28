
function main(): void
{
    const min = 0
    const max = 9
    const array = generate_random_values(min, max, 20)
    print_array(array)
    counting_sort(array, min, max)
    print_array(array)
}

function generate_random_values(min: number, max: number, n: number): number[]
{
    return Array.from({length: n}, () => random_range(min, max))
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

function counting_sort(array: number[], min: number, max: number): void
{
    const n_counts = max - min + 1
    const counts = Array.from({length: n_counts}, () => 0)

    for (let i = 0; i < array.length; i++)
        counts[array[i] - min]++

    let i_array = 0

    for (let i_counts = 0; i_counts < n_counts; i_counts++)
        for (let i = 0; i < counts[i_counts]; i++)
            array[i_array++] = i_counts + min
}

main()

