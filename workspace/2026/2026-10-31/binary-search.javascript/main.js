
function main()
{
    const values = selectionWithoutReplacement(20, { begin: 10, end: 100 })
    console.log(values.join(" "))

    const minTarget = values.at(0) - 1
    const maxTarget = values.at(-1) + 1

    for (let target = minTarget; target <= maxTarget; target++)
    {
        const index = binarySearch(values, target)
        console.log(`target = ${target}, index = ${index}`)
    }
}

function selectionWithoutReplacement(n, { begin, end })
{
    const values = []

    for (let value = begin; value < end; value++)
    {
        let nRemaining = n - values.length
        let nCandidatesRemaining = end - value
        let selectionProbability = nRemaining / nCandidatesRemaining

        if (Math.random() < selectionProbability)
            values.push(value)
    }

    return values
}

function binarySearch(values, target, { begin, end } = {})
{
    begin ??= 0
    end ??= values.length

    if (begin >= end)
        return -1

    const center = Math.floor((begin + end - 1) / 2)

    if (target === values[center])
        return center

    if (target < values[center])
        return binarySearch(values, target, { begin, end: center })
    else
        return binarySearch(values, target, { begin: center + 1, end })
}

main()

