
function main(): void
{
    const array = generate_random_values(20)
    print_array(array)
    comb_sort(array)
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

function comb_sort(array: number[]): void
{
    let gap = array.length
    let swapped = false

    do
    {
        gap = compute_next_gap(gap)
        swapped = false

        for (let i = 0; i + gap < array.length; i++)
        {
            if (array[i] > array[i + gap])
            {
                swap(array, i, i + gap)
                swapped = true
            }
        }
    }
    while (gap > 1 || swapped)
}

function compute_next_gap(gap: number): number
{
    if (gap <= 2)
        return 1

    if (13 <= gap && gap <= 15)
        return 11

    return Math.floor(gap * 10 / 13)
}

function swap<T>(array: T[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

