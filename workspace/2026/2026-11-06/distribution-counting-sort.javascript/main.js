
function main()
{
    const valueRange = { begin: 10, end: 100 }
    const array = generateRandomValues(20, valueRange)
    printArray(array)
    distributionCountingSort(array, valueRange)
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

function distributionCountingSort(array, { begin, end })
{
    const buffer = Array.from(array)
    const counts = Array.from({ length: end - begin }, () => 0)

    for (let i = 0; i < array.length; i++)
        counts[array[i] - begin]++

    for (let i = 1; i < counts.length; i++)
        counts[i] += counts[i - 1]

    for (let i = array.length - 1; 0 <= i; i--)
        buffer[--counts[array[i] - begin]] = array[i]

    for (let i = 0; i < array.length; i++)
        array[i] = buffer[i]
}

main()

