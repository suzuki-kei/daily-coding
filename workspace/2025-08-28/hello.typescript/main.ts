
const names = ["taro", "jiro", "hanako"] as const
type Man = typeof names[0 | 1]
type Woman = typeof names[2]

function main(): void
{
    console.log("names =", names)

    const men: Man[] = ["taro", "jiro"]
    console.log("men =", men)

    const women: Woman[] = ["hanako"]
    console.log("women =", women)
}

main()

