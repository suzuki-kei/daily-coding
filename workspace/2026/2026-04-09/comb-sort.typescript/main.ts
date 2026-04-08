
function main(): void
{
    const array = generate_random_values(20)
    print_array(array)
    comb_sort(array)
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

function comb_sort(array: number[]): void
{
    let gap = array.length
    let done = false

    while (gap > 1 || !done)
    {
        gap = compute_next_gap(gap)
        done = true

        for (let i = 0; i + gap < array.length; i++)
        {
            if (array[i] > array[i + gap])
            {
                swap(array, i, i + gap)
                done = false
            }
        }
    }
}

function compute_next_gap(gap: number): number
{
    if (gap <= 2)
        return 1

    if (gap == 9 || gap == 10)
        return 11

    return Math.floor(gap * 10 / 13)
}

function swap<T>(array: T[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

