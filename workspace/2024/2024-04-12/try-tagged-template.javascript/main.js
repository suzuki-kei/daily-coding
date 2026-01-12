/**
 *
 * タグ付きテンプレート (tagged template)
 * https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Template_literals#%E3%82%BF%E3%82%B0%E4%BB%98%E3%81%8D%E3%83%86%E3%83%B3%E3%83%97%E3%83%AC%E3%83%BC%E3%83%88
 *
 */

function main()
{
    const name = "taro"
    const age = 10
    const result = myTag `That ${name} is a ${age}.`

    console.log(result)
}

function myTag(strings, name, age)
{
    const s1 = strings[0]   // "That "
    const s2 = strings[1]   // " is a "
    const s3 = strings[2]   // "."

    if (age > 99)
        age = "centenarian"
    else
        age = "youngster"

    return [s1, name, s2, age, s3].join("")
}

main()

