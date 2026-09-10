
function main()
{
    const array = generateRandomValues({ min: 10, max: 99, n: 20 })
    printArray(array)
    insertionSort(array)
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

function insertionSort(array)
{
    for (let end = 1; end < array.length; end++)
    {
        for (let i = end; i >= 1; i--)
        {
            let value = array[i]

            while (i >= 1 && value < array[i - 1])
            {
                array[i] = array[i - 1]
                i--
            }

            array[i] = value
        }
    }
}

main()

