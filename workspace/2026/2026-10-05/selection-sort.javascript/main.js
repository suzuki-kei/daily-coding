
function main()
{
    const array = generateRandomValues(20, { begin: 10, end: 100 })
    printArray(array)
    selectionSort(array)
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

function selectionSort(array)
{
    for (let begin = 0; begin + 1 < array.length; begin++)
    {
        let minimumIndex = begin

        for (let i = begin + 1; i < array.length; i++)
            if (array[i] < array[minimumIndex])
                minimumIndex = i

        swap(array, begin, minimumIndex)
    }
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

