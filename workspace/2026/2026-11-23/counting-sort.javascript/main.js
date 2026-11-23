
function main()
{
    const valueRange = { begin: 10, end: 100 }
    const array = generateRandomValues(20, valueRange)
    printArray(array)
    countingSort(array, valueRange)
    printArray(array)
}

function generateRandomValues(n, valueRange)
{
    return Array.from({ length: n }).map(() => randomRange(valueRange))
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

function countingSort(array, { begin, end })
{
    const counts = Array.from({ length: end - begin }, () => 0)

    for (let i = 0; i < array.length; i++)
        counts[array[i] - begin]++

    let outputIndex = 0

    for (let countsIndex = 0; countsIndex < counts.length; countsIndex++)
        for (let i = 0; i < counts[countsIndex]; i++)
            array[outputIndex++] = countsIndex + begin
}

main()

