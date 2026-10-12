
type NumberRange = {
    readonly begin: number,
    readonly end: number,
}

function main(): void
{
    const range = { begin: 0, end: 10 }
    const array = generateRandomValues(20, range)
    printArray(array)
    countingSort(array, range)
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

function countingSort(array: number[], { begin, end }: NumberRange): void
{
    const counts = Array.from({ length: end - begin }, () => 0)

    for (let i = 0; i < array.length; i++)
        counts[array[i] - begin]++

    let iArray = 0

    for (let iCounts = 0; iCounts < counts.length; iCounts++)
        for (let i = 0; i < counts[iCounts]; i++)
            array[iArray++] = iCounts + begin
}

function swap(array: number[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

