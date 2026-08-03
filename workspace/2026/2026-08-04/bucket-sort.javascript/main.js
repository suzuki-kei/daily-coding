
const MIN = 10
const MAX = 99
const N_BUCKETS = 10

function main()
{
    const array = generate_random_values(20, MIN, MAX)
    print_array(array)
    bucket_sort(array, MIN, MAX, N_BUCKETS)
    print_array(array)
}

function generate_random_values(n, min, max)
{
    return Array.from({length: n}, () => random_range(min, max))
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
    for (let i = 0; i + 1 < array.length; i++)
        if (array[i] > array[i + 1])
            return false

    return true
}

function bucket_sort(array, min, max, n_buckets)
{
    const modulo = max - min + 1
    const buckets = Array.from({length: n_buckets}, () => [])

    for (let i = 0; i < array.length; i++)
    {
        const i_buckets = Math.floor((array[i] - min) * n_buckets / modulo)
        buckets[i_buckets].push(array[i])
    }

    for (let i_buckets = 0; i_buckets < n_buckets; i_buckets++)
        insertion_sort(buckets[i_buckets])

    let i_array = 0

    for (let i_buckets = 0; i_buckets < n_buckets; i_buckets++)
        for (let i = 0; i < buckets[i_buckets].length; i++)
            array[i_array++] = buckets[i_buckets][i]
}

function insertion_sort(array)
{
    for (let i = 1; i < array.length; i++)
        insert(array, i)
}

function insert(array, i)
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

