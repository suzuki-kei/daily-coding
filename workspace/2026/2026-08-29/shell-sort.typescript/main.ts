
function main(): void
{
    const array = generate_random_values(10, 99, 20)
    print_array(array)
    shell_sort(array)
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

function shell_sort(array: number[]): void
{
    for (let gap = compute_initial_gap(array.length); gap >= 1; gap = Math.floor(gap / 3))
    {
        for (let n_sorted = gap; n_sorted < array.length; n_sorted++)
        {
            let i = n_sorted
            const value = array[i]

            while (i >= gap && value < array[i - gap])
            {
                array[i] = array[i - gap]
                i -= gap
            }

            array[i] = value
        }
    }
}

function compute_initial_gap(n: number): number
{
    let gap = 1

    while (gap * 3 + 1 < n)
        gap = gap * 3 + 1

    return gap
}

main()

