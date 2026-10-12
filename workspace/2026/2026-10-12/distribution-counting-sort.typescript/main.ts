
type NumberRange = {
    readonly begin: number,
    readonly end: number,
}

function main(): void
{
    const range = { begin: 0, end: 10 }
    const array = generateRandomValues(20, range)
    printArray(array)
    distributionCountingSort(array, range)
    printArray(array)
}

function generateRandomValues(n: number, range: NumberRange): number[]
{
    return Array.from({ length: n }).map(() =>
        randomRange(range)
    )
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

function distributionCountingSort(array: number[], { begin, end }: NumberRange): void
{
    const buffer = Array.from(array)
    const counts = Array.from({ length: end - begin }, () => 0)

    for (let i = 0; i < array.length; i++)
        counts[array[i] - begin]++

    for (let i = 1; i < counts.length; i++)
        counts[i] += counts[i - 1]

    for (let i = array.length - 1; 0 <= i; i--)
        buffer[--counts[array[i] - begin]] = array[i]

    for (let i = 0; i < array.length; i++)
        array[i] = buffer[i]
}

main()

