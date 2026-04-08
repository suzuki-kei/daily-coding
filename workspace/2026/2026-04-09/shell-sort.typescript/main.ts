
function main(): void
{
    const array = generate_random_values(20)
    print_array(array)
    shell_sort(array)
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

function shell_sort(array: number[]): void
{
    for (let hop = compute_initial_hop(array.length); 1 <= hop; hop = Math.floor(hop / 3))
    {
        for (let end = hop; end < array.length; end++)
        {
            let insertion_index = end
            let insertion_value = array[end]

            while (insertion_index >= hop && insertion_value < array[insertion_index - hop])
            {
                array[insertion_index] = array[insertion_index - hop]
                insertion_index -= hop
            }

            array[insertion_index] = insertion_value
        }
    }
}

function compute_initial_hop(n: number): number
{
    let hop = 1

    while (hop * 3 + 1 < n)
        hop = hop * 3 + 1

    return hop
}

function swap<T>(array: T[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

