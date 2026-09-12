
function main(): void
{
    const array = generateRandomValues(20, { min: 10, max: 99 })
    printArray(array)
    combSort(array)
    printArray(array)
}

function generateRandomValues(n: number, { min, max }: { min: number, max: number }): number[]
{
    return Array.from({ length: n }, () => randomRange(min, max))
}

function randomRange(min: number, max: number): number
{
    return Math.floor(Math.random() * (max - min + 1)) + min
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
        gap = computeNextGap(gap)
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
    while (gap > 1 || swapped)
}

function computeNextGap(gap: number): number
{
    if (gap <= 2)
        return 1

    if (13 <= gap && gap <= 15)
        return 11

    return Math.floor(gap / 1.3)
}

function swap<T>(array: T[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

