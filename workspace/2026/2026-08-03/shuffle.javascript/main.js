
function main()
{
    const values = Array.from({length: 20}, (_, i) => i)
    console.log(values.join(" "))
    shuffle(values)
    console.log(values.join(" "))
}

function shuffle(array)
{
    for (let i = 0; i < array.length; i++)
    {
        const target = random_range(i, array.length - 1)
        swap(array, i, target)
    }
}

function random_range(min, max)
{
    return Math.floor(Math.random() * (max - min + 1)) + min
}

function swap(array, index1, index2)
{
    [array[index1], array[index2]] = [array[index2], array[index1]]
}

main()

