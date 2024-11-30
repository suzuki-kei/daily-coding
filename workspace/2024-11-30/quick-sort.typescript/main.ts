
function main(): void
{
    const values = generate_random_values(20)
    print_array(values)
    quick_sort(values)
    print_array(values)
}

function generate_random_values(n: number): number[]
{
    return [...Array(n)].map(_ => Math.floor(Math.random() * 90 + 10))
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
    let increment_index = lower
    let decrement_index = upper
    const pivot = random_select(values, lower, upper)

    while (increment_index <= decrement_index)
    {
        while (values[increment_index] < pivot)
            increment_index++
        while (values[decrement_index] > pivot)
            decrement_index--
        if (increment_index <= decrement_index)
            swap(values, increment_index++, decrement_index--)
    }

    if (lower < decrement_index)
        quick_sort_range(values, lower, decrement_index)
    if (increment_index < upper)
        quick_sort_range(values, increment_index, upper)
}

function random_select<T>(values: T[], lower: number, upper: number): T
{
    return values[Math.floor(Math.random() * (upper - lower + 1) + lower)]
}

function swap<T>(values: T[], index1: number, index2: number): void
{
    [values[index1], values[index2]] = [values[index2], values[index1]]
}

main()

