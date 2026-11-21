
type NumberRange = {
    begin: number
    end: number
}

function main(): void
{
    const valueRange = { begin: 10, end: 100 }
    const array = generateRandomValues(20, valueRange)
    printArray(array)
    heapSort(array)
    printArray(array)
}

function generateRandomValues(n: number, valueRange: NumberRange): number[]
{
    return Array.from({ length: n }, () => randomRange(valueRange))
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

function heapSort(array: number[]): void
{
    heapBuild(array)
    heapPopAll(array)
}

function heapBuild(array: number[]): void
{
    for (let i = Math.floor(array.length / 2) - 1; 0 <= i; i--)
        heapShiftDown(array, array.length, i)
}

function heapPopAll(array: number[]): void
{
    for (let i = array.length - 1; 1 <= i; i--)
        heapPop(array, i)
}

function heapPop(array: number[], i: number): void
{
    swap(array, i, 0)
    heapShiftDown(array, i, 0)
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

        if (i === maximumIndex)
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

