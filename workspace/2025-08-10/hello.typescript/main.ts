
type A = "apple" | "banana" | "orange"
type B = "banana" | "cat" | "dog"
type C = A & B

function main(): void
{
    const a: A = "apple"
    const b: B = "banana"
    const c: C = "banana"

    console.log("OK")
}

main()

