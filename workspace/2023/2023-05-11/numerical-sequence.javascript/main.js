
function factorial(n) {
    if (n == 0) {
        return 1
    }
    return n * factorial(n - 1)
}

function fibonacci(n) {
    if (n == 0 || n == 1) {
        return n
    }
    return fibonacci(n - 1) + fibonacci(n - 2)
}

function fizzbuzz(n) {
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

function range(min, max) {
    return Array.from(Array(max - min + 1).keys()).map(x => x + min)
}

function show_numerical_sequence(description, f, min, max) {
    console.log(description + ":")
    console.log(range(min, max).map(f).join(" "))
}

function main() {
    show_numerical_sequence("factorials", factorial, 1, 10)
    show_numerical_sequence("fibonacci numbers", fibonacci, 0, 20)
    show_numerical_sequence("FizzBuzz values", fizzbuzz, 1, 100)
}

main()

