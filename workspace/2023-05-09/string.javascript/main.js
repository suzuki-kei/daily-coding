
function main() {
    let string = "aacaaaac"
    console.log("string          : " + string)
    console.log("prefixes        : " + prefixes(string).toString())
    console.log("proper prefixes : " + proper_prefixes(string).toString())
    console.log("suffixes        : " + suffixes(string).toString())
    console.log("proper suffixes : " + proper_suffixes(string).toString())
    console.log("lps array       : " + lps_array(string).toString())
}

main()

