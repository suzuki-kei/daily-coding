
function main()
{
    const valueRange = { begin: 10, end: 100 }
    const array = generateRandomValues(20, valueRange)
    printArray(array)
    bubbleSort(array)
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

function bubbleSort(array)
{
    for (let end = array.length; 1 < end; end--)
        for (let i = 0; i + 1 < end; i++)
            if (array[i] > array[i + 1])
                swap(array, i, i + 1)
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

