
function main(): void
{
    const array = generateRandomValues(20, { min: 10, max: 99 })
    printArray(array)
    shellSort(array)
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

function shellSort(array: number[]): void
{
    for (let gap = computeInitialGap(array.length); gap >= 1; gap = Math.floor(gap / 3))
    {
        for (let end = gap; end < array.length; end++)
        {
            let i = end
            const value = array[end]

            while (i >= gap && value < array[i - gap])
            {
                array[i] = array[i - gap]
                i -= gap
            }

            array[i] = value
        }
    }
}

function computeInitialGap(n: number): number
{
    let gap = 1

    while (gap * 3 + 1 < n)
        gap = gap * 3 + 1

    return gap
}

function swap<T>(array: T[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

