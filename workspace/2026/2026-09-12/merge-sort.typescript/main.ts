
function main(): void
{
    const array = generateRandomValues(20, { min: 10, max: 99 })
    printArray(array)
    mergeSort(array)
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

function mergeSort(array: number[]): void
{
    const buffer = Array.from(array)
    let input = array
    let output = buffer

    for (let chunkSize = 1; chunkSize < array.length; chunkSize *= 2)
    {
        for (let i = 0; i < array.length; i += chunkSize * 2)
        {
            merge(
                output,
                i,
                input,
                i,
                Math.min(array.length, i + chunkSize),
                Math.min(array.length, i + chunkSize),
                Math.min(array.length, i + chunkSize * 2))
        }

        [input, output] = [output, input]
    }

    if (array === output)
        for (let i = 0; i < array.length; i++)
            array[i] = buffer[i]
}

function merge(
    output: number[],
    outputIndex: number,
    input: readonly number[],
    begin1: number,
    end1: number,
    begin2: number,
    end2: number,
): void
{
    while (begin1 < end1 && begin2 < end2)
        if (input[begin1] <= input[begin2])
            output[outputIndex++] = input[begin1++]
        else
            output[outputIndex++] = input[begin2++]

    while (begin1 < end1)
        output[outputIndex++] = input[begin1++]

    while (begin2 < end2)
        output[outputIndex++] = input[begin2++]
}

main()

