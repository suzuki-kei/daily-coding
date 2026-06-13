
function main(): void
{
    const array = generate_random_values(20)
    print_array(array)
    insertion_sort(array)
    print_array(array)
}

function generate_random_values(n: number): number[]
{
    return Array.from({length: n}, () => random_range(10, 99))
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

function insertion_sort(array: number[]): void
{
    for (let i = 1; i < array.length; i++)
        insert(array, i)
}

function insert(array: number[], i: number): void
{
    const value = array[i]

    while (i >= 1 && value < array[i - 1])
    {
        array[i] = array[i - 1]
        i--
    }
    array[i] = value
}

main()

