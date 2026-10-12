
type NumberRange = {
    readonly begin: number,
    readonly end: number,
}

function main(): void
{
    const array = generateRandomValues(20, { begin: 10, end: 100 })
    printArray(array)
    combSort(array)
    printArray(array)
}

function generateRandomValues(n: number, range: NumberRange): number[]
{
    return Array.from({ length: n }).map(() =>
        randomRange(range)
    )
}

function randomRange({ begin, end }: NumberRange): number
{
    return Math.floor(Math.random() * (end - begin)) + begin
}

function printArray(array: readonly number[]): void
{
    if (isSorted(array))
        console.log(`${array.join(" ")} (sorted)`)
    else
        console.log(`${array.join(" ")} (not sorted)`)
}

function isSorted(array: readonly number[]): boolean
{
    for (let i = 0; i + 1 < array.length; i++)
        if (array[i] > array[i + 1])
            return false

    return true
}

function combSort(array: number[]): void
{
    let gap = array.length
    let swapped = false

    do
    {
        gap = toNextGap(gap)
        swapped = false

        for (let i = 0; i + gap < array.length; i++)
        {
            if (array[i] > array[i + gap])
            {
                swap(array, i, i + gap)
                swapped = true
            }
        }
    }
    while (1 < gap || swapped)
}

function toNextGap(gap: number): number
{
    if (gap <= 2)
        return 1

    if (13 <= gap && gap <= 15)
        return 11

    return Math.floor(gap / 1.3)
}

function swap(array: number[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

