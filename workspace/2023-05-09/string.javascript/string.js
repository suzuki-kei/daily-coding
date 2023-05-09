
function range(min, max) {
    return Array.from(Array(max - min + 1).keys()).map(x => x + min)
}

function prefixes(string) {
    return range(0, string.length).map(i => {
        return string.substring(0, i)
    })
}

function is_prefix(string1, string2) {
    return string.startsWith(string2)
}

function proper_prefixes(string) {
    return range(0, string.length - 1).map(i => {
        return string.substring(0, i)
    })
}
function is_proper_prefix(string1, string2) {
    return string1.length != string2.length && string1.startsWith(string2)
}

function suffixes(string) {
    return range(0, string.length).map(i => {
        return string.substring(string.length - i, string.length)
    })
}

function is_suffix(string1, string2) {
    return string1.endsWith(string2)
}

function proper_suffixes(string) {
    return range(0, string.length - 1).map(i => {
        return string.substring(string.length - i, string.length)
    })
}

function is_proper_suffix(string1, string2) {
    return string1.length != string2.length && string1.endsWith(string2)
}

// 先頭 i 文字.
function first_i_chars(string, i) {
    return string.substring(0, i)
}

function intersection(array1, array2) {
    return array1.filter(x => array2.includes(x))
}

// LPS (Longest proper Prefix Suffix) Array.
function lps_array(string) {
    return range(1, string.length).map(i => {
        let substring = string.substring(0, i)
        return Math.max(...(intersection(proper_prefixes(substring), proper_suffixes(substring)).map(_ => _.length)))
    })
}

