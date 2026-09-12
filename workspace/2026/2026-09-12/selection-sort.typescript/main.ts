
function main(): void
{
    const array = generateRandomValues(20, { min: 10, max: 99 })
    printArray(array)
    selectionSort(array)
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

function selectionSort(array: number[]): void
{
    for (let begin = 0; begin + 1 < array.length; begin++)
    {
        let minimumIndex = begin

        for (let i = begin + 1; i < array.length; i++)
            if (array[i] < array[minimumIndex])
                minimumIndex = i

        swap(array, begin, minimumIndex)
    }
}

function swap<T>(array: T[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

