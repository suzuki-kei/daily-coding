
function main()
{
    const array = generateRandomValues(20, { begin: 10, end: 100 })
    printArray(array)
    shellSort(array)
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

function shellSort(array)
{
    for (let gap = toInitialGap(array.length); gap >= 1; gap = Math.floor(gap / 3))
    {
        for (let end = gap; end < array.length; end++)
        {
            let i = end
            const value = array[end]

            while (i >= gap && value < array[i - gap])
            {
                array[i] = array[i - gap]
                i -= gap
            }

            array[i] = value
        }
    }
}

function toInitialGap(n)
{
    let gap = 1

    while (gap * 3 + 1 < n)
        gap = gap * 3 + 1

    return gap
}

main()

