
function main()
{
    demonstrate("partition 2-way", partition2Way)
    demonstrate("partition 3-way", partition3Way)
}

function demonstrate(label, partition)
{
    console.log(`==== ${label}`)
    const valueRange = { begin: 10, end: 100 }
    const array = generateRandomValues(20, valueRange)
    printArray(array)
    quickSort(array, partition)
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

function quickSort(array, partition, { begin = 0, end = array.length } = {})
{
    while (begin < end - 1)
    {
        const middle = partition(array, { begin, end })
        const nLeft = middle.begin - begin
        const nRight = end - middle.end

        if (nLeft < nRight)
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

function partition2Way(array, { begin, end })
{
    let increasingIndex = begin
    let decreasingIndex = end - 1
    const pivot = array[randomRange({ begin, end })]

    while (increasingIndex <= decreasingIndex)
    {
        while (array[increasingIndex] < pivot)
            increasingIndex++

        while (array[decreasingIndex] > pivot)
            decreasingIndex--

        if (increasingIndex <= decreasingIndex)
            swap(array, increasingIndex++, decreasingIndex--)
    }

    return {
        begin: decreasingIndex + 1,
        end: increasingIndex,
    }
}

function partition3Way(array, { begin, end })
{
    let i = begin
    let lessEnd = begin
    let greaterBegin = end
    const pivot = array[randomRange({ begin, end })]

    while (i < greaterBegin)
    {
        if (array[i] < pivot)
            swap(array, lessEnd++, i++)
        else if (array[i] > pivot)
            swap(array, i, --greaterBegin)
        else
            i++
    }

    return {
        begin: lessEnd,
        end: greaterBegin,
    }
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

