
function main() {
    show("factorials", factorial, 1, 10)
    show("fibonacci numbers", fibonacci, 0, 20)
    show("FizzBuzz values", fizz_buzz, 1, 100)
}

function show(description, f, min, max) {
    console.log(description + ":")
    console.log(range(min, max).map(f).join(" "))
}

function range(min, max) {
    return Array.from(Array(max - min + 1).keys())
}

function factorial(n) {
    if (n == 0) {
        return 1
    }
    return n * factorial(n - 1)
}

function fibonacci(n) {
    if (n == 0) {
        return 0
    }
    if (n == 1) {
        return 1
    }
    return fibonacci(n - 1) + fibonacci(n - 2)
}

function fizz_buzz(n) {
    if (n % 15 == 0) {
        return "FizzBuzz"
    }
    if (n % 5 == 0) {
        return "Buzz"
    }
    if (n % 3 == 0) {
        return "Fizz"
    }
    return n
}

main()

