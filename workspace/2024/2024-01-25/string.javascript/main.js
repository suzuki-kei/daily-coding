
function main()
{
    const s = "abcabcabc"
    console.log(`s               = ${format(s)}`)
    console.log(`prefixes        = ${format(prefixes(s))}`)
    console.log(`proper prefixes = ${format(proper_prefixes(s))}`)
    console.log(`suffixes        = ${format(suffixes(s))}`)
    console.log(`proper suffixes = ${format(proper_suffixes(s))}`)
    console.log(`lps             = ${format(lps(s))}`)
    console.log(`lps array       = ${format(lps_array(s))}`)
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
    return Array.from(Array(max - min + 1).keys()).map(x => x + min)
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
    return sequence(0, s.length).reverse().map(n => s.substring(n, s.length))
}

function proper_suffixes(s)
{
    return sequence(1, s.length).reverse().map(n => s.substring(n, s.length))
}

function lps(s)
{
    return intersection(proper_prefixes(s), proper_suffixes(s)).reduce((s1, s2) => s1.length > s2.length ? s1 : s2)
}

function lps_array(s)
{
    return prefixes(s).slice(1).map(prefix => lps(prefix).length)
}

function intersection(values1, values2)
{
    return values1.filter(value => values2.includes(value))
}

main()

