
function main()
{
    const array = generateRandomValues(20, { begin: 10, end: 100 })
    printArray(array)
    heapSort(array)
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

function heapSort(array)
{
    heapBuild(array)
    heapPopAll(array)
}

function heapBuild(array)
{
    for (let i = Math.floor(array.length / 2) - 1; i >= 0; i--)
        heapShiftDown(array, array.length, i)
}

function heapPopAll(array)
{
    for (let i = array.length - 1; i >= 1; i--)
    {
        swap(array, i, 0)
        heapShiftDown(array, i, 0)
    }
}

function heapShiftDown(array, n, i)
{
    while (i * 2 + 1 < n)
    {
        let maximumIndex = i
        const leftIndex = i * 2 + 1
        const rightIndex = i * 2 + 2

        if (leftIndex < n && array[leftIndex] > array[maximumIndex])
            maximumIndex = leftIndex

        if (rightIndex < n && array[rightIndex] > array[maximumIndex])
            maximumIndex = rightIndex

        if (i === maximumIndex)
            break

        swap(array, i, maximumIndex)
        i = maximumIndex
    }
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

