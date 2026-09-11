
type PartitionResult = {
    leftLast: number,
    rightFirst: number,
}

type Partition = (
    array: number[],
    first: number,
    last: number,
) => PartitionResult

function main(): void
{
    demonstration("partition 2-way", partition2Way)
    demonstration("partition 3-way", partition3Way)
}

function demonstration(label: string, partition: Partition): void
{
    console.log(`==== ${label}`)
    const array = generateRandomValues({ min: 10, max: 99, n: 20 })
    printArray(array)
    quickSort(array, partition)
    printArray(array)
}

function generateRandomValues({ min, max, n }: { min: number, max: number, n: number }): number[]
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

function quickSort(
    array: number[],
    partition: Partition,
    { first = 0, last = array.length - 1 }: { first?: number, last?: number } = {}
): void
{
    while (first < last)
    {
        const { leftLast, rightFirst } = partition(array, first, last)
        const nLeft = leftLast - first + 1
        const nRight = last - rightFirst + 1

        if (nLeft <= nRight)
        {
            quickSort(array, partition, { first, last: leftLast })
            first = rightFirst
        }
        else
        {
            quickSort(array, partition, { first: rightFirst, last })
            last = leftLast
        }
    }
}

function partition2Way(array: number[], first: number, last: number): PartitionResult
{
    let incrementIndex = first
    let decrementIndex = last
    const pivot = array[randomRange(first, last)]

    while (incrementIndex <= decrementIndex)
    {
        while (array[incrementIndex] < pivot)
            incrementIndex++

        while (array[decrementIndex] > pivot)
            decrementIndex--

        if (incrementIndex <= decrementIndex)
            swap(array, incrementIndex++, decrementIndex--)
    }

    return {
        leftLast: decrementIndex,
        rightFirst: incrementIndex,
    }
}

function partition3Way(array: number[], first: number, last: number): PartitionResult
{
    let lessEnd = first
    let incrementIndex = first
    let decrementIndex = last
    const pivot = array[randomRange(first, last)]

    while (incrementIndex <= decrementIndex)
    {
        if (array[incrementIndex] < pivot)
            swap(array, lessEnd++, incrementIndex++)
        else if (array[incrementIndex] > pivot)
            swap(array, incrementIndex, decrementIndex--)
        else
            incrementIndex++
    }

    return {
        leftLast: lessEnd - 1,
        rightFirst: incrementIndex,
    }
}

function swap<T>(array: T[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

