
type NumberRange = {
    readonly begin: number,
    readonly end: number,
}

type Partition = (
    array: number[],
    range: NumberRange,
) => NumberRange

function main(): void
{
    demonstration("partition 2-way", partition2Way)
    demonstration("partition 3-way", partition3Way)
}

function demonstration(label: string, partition: Partition): void
{
    console.log(`==== ${label}`)

    const array = generateRandomValues(20, { begin: 10, end: 100 })
    printArray(array)
    quickSort(array, partition)
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

function quickSort(array: number[], partition: Partition, range?: NumberRange): void
{
    let begin = range?.begin ?? 0
    let end = range?.end ?? array.length

    while (begin < end - 1)
    {
        const middle = partition(array, { begin, end })
        const nLeft = middle.begin - begin
        const nRight = end - middle.end

        if (nLeft <= nRight)
        {
            quickSort(array, partition, { begin, end: middle.begin })
            begin = middle.end
        }
        else
        {
            quickSort(array, partition, { begin: middle.end, end })
            end = middle.begin
        }
    }
}

function partition2Way(array: number[], { begin, end }: NumberRange): NumberRange
{
    let incrementIndex = begin
    let decrementIndex = end - 1
    const pivot = array[randomRange({ begin, end })]

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
        begin: decrementIndex + 1,
        end: incrementIndex,
    }
}

function partition3Way(array: number[], { begin, end }: NumberRange): NumberRange
{
    let i = begin
    let lessEnd = begin
    let greaterBegin = end
    const pivot = array[randomRange({ begin, end })]

    while (i < greaterBegin)
        if (array[i] < pivot)
            swap(array, lessEnd++, i++)
        else if (array[i] > pivot)
            swap(array, i, --greaterBegin)
        else
            i++

    return {
        begin: lessEnd,
        end: greaterBegin,
    }
}

function swap(array: number[], index1: number, index2: number): void
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

