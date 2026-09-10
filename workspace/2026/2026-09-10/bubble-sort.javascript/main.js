
function main()
{
    const array = generateRandomValues({ min: 10, max: 99, n: 20 })
    printArray(array)
    bubbleSort(array)
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

function bubbleSort(array)
{
    for (let last = array.length - 1; last >= 1; last--)
        for (let i = 0; i + 1 <= last; i++)
            if (array[i] > array[i + 1])
                swap(array, i, i + 1)
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

