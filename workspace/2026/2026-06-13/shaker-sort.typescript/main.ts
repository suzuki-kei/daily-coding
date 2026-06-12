
function main(): void
{
    const array = generate_random_values(20)
    print_array(array)
    shaker_sort(array)
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

function shaker_sort(array: number[]): void
{
    let lower = 0
    let upper = array.length - 1

    while (lower < upper)
    {
        for (let i = lower; i + 1 <= upper; i++)
            if (array[i] > array[i + 1])
                swap(array, i, i + 1)
        upper--

        for (let i = upper; i - 1 >= lower; i--)
            if (array[i] < array[i - 1])
                swap(array, i, i - 1)
        lower++
    }
}

function swap<T>(array: T[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

