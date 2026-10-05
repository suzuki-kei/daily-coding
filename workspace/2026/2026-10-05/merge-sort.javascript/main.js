
function main()
{
    const array = generateRandomValues(20, { begin: 10, end: 100 })
    printArray(array)
    mergeSort(array)
    printArray(array)
}

function generateRandomValues(n, { begin, end })
{
    return Array.from({ length: n }).map(() =>
        randomRange({ begin, end })
    )
}

function randomRange({ begin, end })
{
    return Math.floor(Math.random() * (end - begin)) + begin
}

function printArray(array)
{
    if (isSorted(array))
        console.log(`${array.join(" ")} (sorted)`)
    else
        console.log(`${array.join(" ")} (not sorted)`)
}

function isSorted(array)
{
    for (let i = 0; i + 1 < array.length; i++)
        if (array[i] > array[i + 1])
            return false

    return true
}

function mergeSort(array)
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

function merge(output, outputIndex, input, begin1, end1, begin2, end2)
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

