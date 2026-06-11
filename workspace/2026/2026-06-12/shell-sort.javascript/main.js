
function main()
{
    const array = generate_random_values(20)
    print_array(array)
    shell_sort(array)
    print_array(array)
}

function generate_random_values(n)
{
    return [...Array(n)].map(
        _ => random_range(10, 99)
    )
}

function random_range(min, max)
{
    return Math.floor(Math.random() * (max - min + 1)) + min
}

function print_array(array)
{
    if (is_sorted(array))
        console.log(`${array.join(" ")} (sorted)`)
    else
        console.log(`${array.join(" ")} (not sorted)`)
}

function is_sorted(array)
{
    if (array.length <= 1)
        return true

    return [...Array(array.length - 1).keys()].every(
        i => array[i] <= array[i + 1]
    )
}

function shell_sort(array)
{
    for (const hop of generate_hops(array.length))
        for (let i = hop; i < array.length; i++)
            insert(array, i, hop)
}

function *generate_hops(n)
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

function insert(array, i, hop)
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

