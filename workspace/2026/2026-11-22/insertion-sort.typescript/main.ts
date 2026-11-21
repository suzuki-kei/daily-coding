
type NumberRange = {
    begin: number
    end: number
}

function main(): void
{
    const valueRange = { begin: 10, end: 100 }
    const array = generateRandomValues(20, valueRange)
    printArray(array)
    insertionSort(array)
    printArray(array)
}

function generateRandomValues(n: number, valueRange: NumberRange): number[]
{
    return Array.from({ length: n }, () => randomRange(valueRange))
}

function randomRange({ begin, end }: NumberRange): number
{
    return Math.floor(Math.random() * (end - begin)) + begin
}

function printArray(array: readonly number[]): void
{
    if (isSorted(array))
        console.log(`${array.join(" ")} (sorted)`)
    else
        console.log(`${array.join(" ")} (not sorted)`)
}

function isSorted(array: readonly number[]): boolean
{
    for (let i = 0; i + 1 < array.length; i++)
        if (array[i] > array[i + 1])
            return false

    return true
}

function insertionSort(array: number[]): void
{
    for (let end = 1; end < array.length; end++)
    {
        let i = end
        const value = array[end]

        while (1 <= i && value < array[i - 1])
        {
            array[i] = array[i - 1]
            i--
        }

        array[i] = value
    }
}

main()

