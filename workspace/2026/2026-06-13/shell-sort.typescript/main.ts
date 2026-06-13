
function main(): void
{
    const array = generate_random_values(20)
    print_array(array)
    shell_sort(array)
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

function shell_sort(array: number[]): void
{
    for (const hop of generate_hops(array.length))
        for (let i = hop; i < array.length; i++)
            insert(array, i, hop)
}

function *generate_hops(n: number): Generator<number, void, void>
{
    let hop = 1

    while (hop * 3 + 1 < n)
        hop = hop * 3 + 1

    while (hop >= 1)
    {
        yield hop
        hop = Math.floor(hop / 3)
    }
}

function insert(array: number[], i: number, hop: number): void
{
    const value = array[i]

    while (i >= hop && value < array[i - hop])
    {
        array[i] = array[i - hop]
        i -= hop
    }
    array[i] = value
}

main()

