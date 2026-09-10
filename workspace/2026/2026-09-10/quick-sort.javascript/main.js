
function main()
{
    demonstration("partition 2-way", partition2Way)
    demonstration("partition 3-way", partition3Way)
}

function demonstration(label, partition)
{
    console.log(`==== ${label}`)
    const array = generateRandomValues({ min: 10, max: 99, n: 20 })
    printArray(array)
    quickSort(array, { partition })
    printArray(array)
}

function generateRandomValues({ min, max, n })
{
    return Array.from({ length: n }, () => randomRange(min, max))
}

function randomRange(min, max)
{
    return Math.floor(Math.random() * (max - min + 1)) + min
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
    return range(0, array.length - 2).every(i => array[i] <= array[i + 1]);
}

function range(min, max)
{
    return Array.from({ length: max - min + 1 }, (_, i) => i + min)
}

function quickSort(array, { partition, first = 0, last = array.length - 1 })
{
    while (first < last)
    {
        const { leftLast, rightFirst } = partition(array, { first, last })
        const nLeft = leftLast - first
        const nRight = last - rightFirst

        if (nLeft <= nRight)
        {
            quickSort(array, { partition, first, last: leftLast })
            first = rightFirst
        }
        else
        {
            quickSort(array, { partition, first: rightFirst, last })
            last = leftLast
        }
    }
}

function partition2Way(array, { first, last })
{
    let incrementIndex = first
    let decrementIndex = last
    const pivot = array[randomRange(first, last)]

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
        leftLast: decrementIndex,
        rightFirst: incrementIndex,
    }
}

function partition3Way(array, { first, last })
{
    let lessEnd = first
    let incrementIndex = first
    let decrementIndex = last
    const pivot = array[randomRange(first, last)]

    while (incrementIndex <= decrementIndex)
    {
        if (array[incrementIndex] < pivot)
            swap(array, lessEnd++, incrementIndex++)
        else if (array[incrementIndex] > pivot)
            swap(array, incrementIndex, decrementIndex--)
        else
            incrementIndex++
    }

    return {
        leftLast: lessEnd - 1,
        rightFirst: incrementIndex,
    }
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

