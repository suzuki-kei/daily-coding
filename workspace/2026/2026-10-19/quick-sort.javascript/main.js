
function main()
{
    demonstration("partition 2-way", partition2Way)
    demonstration("partition 3-way", partition3Way)
}

function demonstration(label, partition)
{
    console.log(`==== ${label}`)

    const array = generateRandomValues(20, { begin: 10, end: 100 })
    printArray(array)
    quickSort(array, partition)
    printArray(array)
}

function generateRandomValues(n, { begin, end })
{
    return Array.from({ length: n }, () => randomRange({ begin, end }))
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
        const middle = partition(array, begin, end)
        const nLeft = middle.begin - begin
        const nRight = end - middle.end

        if (nLeft <= nRight)
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

function partition2Way(array, begin, end)
{
    let incrementIndex = begin
    let decrementIndex = end - 1
    const pivot = array[randomRange({ begin, end })]

    while (incrementIndex <= decrementIndex)
    {
        while (array[incrementIndex] < pivot)
            incrementIndex++

        while (array[decrementIndex] > pivot)
            decrementIndex--

        if (incrementIndex <= decrementIndex)
            swap(array, incrementIndex++, decrementIndex--)
    }

    return {
        begin: decrementIndex + 1,
        end: incrementIndex,
    }
}

function partition3Way(array, begin, end)
{
    let i = begin
    let lessEnd = begin
    let greaterBegin = end
    const pivot = array[randomRange({ begin, end })]

    while (i < greaterBegin)
        if (array[i] < pivot)
            swap(array, lessEnd++, i++)
        else if (array[i] > pivot)
            swap(array, i, --greaterBegin)
        else
            i++

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

