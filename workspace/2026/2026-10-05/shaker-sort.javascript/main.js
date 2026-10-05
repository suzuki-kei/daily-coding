
function main()
{
    const array = generateRandomValues(20, { begin: 10, end: 100 })
    printArray(array)
    shakerSort(array)
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

function shakerSort(array)
{
    let first = 0
    let last = array.length - 1

    while (first < last)
    {
        for (let i = first; i + 1 <= last; i++)
            if (array[i] > array[i + 1])
                swap(array, i, i + 1)
        last--

        for (let i = last; i - 1 >= first; i--)
            if (array[i] < array[i - 1])
                swap(array, i, i - 1)
        first++
    }
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

