
function main()
{
    const values = selection_without_replacement(10, 99, 20)
    console.log(values.join(" "))
}

function selection_without_replacement(min, max, n)
{
    const values = []

    for (let value = min; value <= max; value++)
    {
        const numerator = n - values.length
        const denominator = max - value + 1
        const r = Math.random()

        if (r < numerator / denominator)
            values.push(value)
    }

    return values
}

main()

