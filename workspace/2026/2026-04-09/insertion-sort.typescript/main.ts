
function main(): void
{
    const array = generate_random_values(20)
    print_array(array)
    insertion_sort(array)
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

function insertion_sort(array: number[]): void
{
    for (let end = 1; end < array.length; end++)
    {
        let insertion_index = end
        let insertion_value = array[end]

        while (insertion_index >= 1 && insertion_value < array[insertion_index - 1])
        {
            array[insertion_index] = array[insertion_index - 1]
            insertion_index--
        }

        array[insertion_index] = insertion_value
    }
}

main()

