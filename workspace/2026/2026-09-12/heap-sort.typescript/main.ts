
function main(): void
{
    const array = generateRandomValues(20, { min: 10, max: 99 })
    printArray(array)
    heapSort(array)
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

function heapSort(array: number[]): void
{
    heapMake(array)
    heapPopAll(array)
}

function heapMake(array: number[]): void
{
    for (let i = array.length / 2 - 1; i >= 0; i--)
        heapShiftDown(array, array.length, i)
}

function heapPopAll(array: number[]): void
{
    for (let i = array.length - 1; i >= 1; i--)
    {
        swap(array, i, 0)
        heapShiftDown(array, i, 0)
    }
}

function heapShiftDown(array: number[], n: number, i: number): void
{
    while (i * 2 + 1 < n)
    {
        let maximumIndex = i
        const leftIndex = i * 2 + 1
        const rightIndex = i * 2 + 2

        if (leftIndex < n && array[leftIndex] > array[maximumIndex])
            maximumIndex = leftIndex

        if (rightIndex < n && array[rightIndex] > array[maximumIndex])
            maximumIndex = rightIndex

        if (i == maximumIndex)
            break

        swap(array, i, maximumIndex)
        i = maximumIndex
    }
}

function swap<T>(array: T[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

