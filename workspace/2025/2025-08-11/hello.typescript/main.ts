
function main(): void
{
    const a: A = "apple"
    const b: B = "google"
    const c: C = a
    console.log(`a = ${a}, b = ${b}, c = ${c}`)
}

type A = "apple" | "banana" | "curry"
type B = "apple" | "google" | "microsoft"
type C = A & B

main()

