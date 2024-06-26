
function main()
{
    const s = "abcabcabc"

    console.log(`s                  = ${format(s)}`)
    console.log(`prefixes(s)        = ${format(prefixes(s))}`)
    console.log(`proper_prefixes(s) = ${format(proper_prefixes(s))}`)
    console.log(`suffixes(s)        = ${format(suffixes(s))}`)
    console.log(`proper_suffixes(s) = ${format(proper_suffixes(s))}`)
    console.log(`lps(s)             = ${format(lps(s))}`)
    console.log(`lps_array(s)       = ${format(lps_array(s))}`)
}

function format(x)
{
    if (typeof(x) == "string")
        return `"${x}"`
    if (Array.isArray(x))
        return x.map(format).join(", ")
    return String(x)
}

function sequence(min, max)
{
    return [...Array(max - min + 1).keys()].map(x => x + min)
}

function prefixes(s)
{
    return sequence(0, s.length).map(n => s.substring(0, n))
}

function proper_prefixes(s)
{
    return sequence(0, s.length - 1).map(n => s.substring(0, n))
}

function suffixes(s)
{
    return sequence(0, s.length).map(n => s.substring(n)).reverse()
}

function proper_suffixes(s)
{
    return sequence(1, s.length).map(n => s.substring(n)).reverse()
}

function lps(s)
{
    const longer = (xs, ys) => xs.length > ys.length ? xs : ys
    return intersection(proper_prefixes(s), proper_suffixes(s)).reduce(longer)
}

function intersection(xs, ys)
{
    return xs.filter(x => ys.includes(x))
}

function lps_array(s)
{
    return prefixes(s).slice(1).map(prefix => lps(prefix).length)
}

main()

