
function main()
{
    const valueRange = { begin: 10, end: 100 }
    const array = generateRandomValues(20, valueRange)
    printArray(array)
    countingSort(array, valueRange)
    printArray(array)
}

function generateRandomValues(n, { begin, end })
{
    return Array.from({ length: n }, () =>
        randomRange(begin, end)
    )
}

function randomRange(begin, end)
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

    let iArray = 0

    for (let iCounts = 0; iCounts < counts.length; iCounts++)
        for (let i = 0; i < counts[iCounts]; i++)
            array[iArray++] = iCounts + begin
}

main()

