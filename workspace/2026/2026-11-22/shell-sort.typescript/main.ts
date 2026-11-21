
type NumberRange = {
    begin: number
    end: number
}

function main(): void
{
    const valueRange = { begin: 10, end: 100 }
    const array = generateRandomValues(20, valueRange)
    printArray(array)
    shellSort(array)
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

function shellSort(array: number[]): void
{
    for (let gap = toInitialGap(array.length); 1 <= gap; gap = Math.floor(gap / 3))
    {
        for (let end = gap; end < array.length; end++)
        {
            let i = end
            const value = array[end]

            while (gap <= i && value < array[i - gap])
            {
                array[i] = array[i - gap]
                i -= gap
            }

            array[i] = value
        }
    }
}

function toInitialGap(n: number): number
{
    let gap = 1

    while (gap * 3 + 1 < n)
        gap = gap * 3 + 1

    return gap
}

main()

