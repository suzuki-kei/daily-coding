
function main(): void
{
    const values = generate_random_values(20)
    print_array(values)
    quick_sort(values)
    print_array(values)
}

function generate_random_values(n: number): number[]
{
    return [...Array(n).keys()].map(_ => Math.floor(Math.random() * 90 + 10))
}

function print_array(values: number[]): void
{
    if (is_sorted(values))
        console.log(`${values.join(" ")} (sorted)`)
    else
        console.log(`${values.join(" ")} (not sorted)`)
}

function is_sorted(values: number[]): boolean
{
    for (let i = 0; i < values.length - 1; i++)
        if (values[i] > values[i + 1])
            return false
    return true
}

function quick_sort(values: number[]): void
{
    quick_sort_range(values, 0, values.length - 1)
}

function quick_sort_range(values: number[], lower: number, upper: number): void
{
    let lower_index = lower
    let upper_index = upper
    const pivot = values[Math.floor((lower + upper) / 2)]

    while (lower_index <= upper_index)
    {
        while (values[lower_index] < pivot)
            lower_index++
        while (values[upper_index] > pivot)
            upper_index--
        if (lower_index <= upper_index)
            swap(values, lower_index++, upper_index--)
    }

    if (lower < upper_index)
        quick_sort_range(values, lower, upper_index)
    if (lower_index < upper)
        quick_sort_range(values, lower_index, upper)
}

function swap<T>(values: T[], index1: number, index2: number): void
{
    [values[index1], values[index2]] = [values[index2], values[index1]]
}

main()

