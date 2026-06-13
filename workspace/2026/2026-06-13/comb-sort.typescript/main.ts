
function main(): void
{
    const array = generate_random_values(20)
    print_array(array)
    comb_sort(array)
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

function comb_sort(array: number[]): void
{
    let gap = array.length
    let done = false

    while (!done)
    {
        gap = compute_next_gap(gap)
        done = gap === 1

        for (let i = 0; i + gap < array.length; i++)
            if (array[i] > array[i + gap])
                swap(array, i, i + gap)
    }
}

function compute_next_gap(gap: number): number
{
    gap = Math.floor(gap * 10 / 13)

    if (gap < 1)
        gap = 1
    else if (gap === 9 || gap === 10)
        gap = 11

    return gap
}

function swap<T>(array: T[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

