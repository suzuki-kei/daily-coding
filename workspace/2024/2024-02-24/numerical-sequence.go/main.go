package main

import "fmt"

func main() {
    print_sequence("factorials", factorial, 1, 10)
    print_sequence("fibonacci numbers", fibonacci, 0, 20)
    print_sequence("fizz buzz values", fizz_buzz, 1, 100)
}

func print_sequence[T any](description string, f func(int) T, min int, max int) {
    fmt.Printf("%s:\n", description)

    var separator = ""
    for i := min; i <= max; i++ {
        fmt.Print(separator, f(i))
        separator = " "
    }
    fmt.Println()
}

func factorial(n int) int {
    if (n == 0) {
        return 1
    } else {
        return n * factorial(n - 1)
    }
}

func fibonacci(n int) int {
    if (n == 0) {
        return 0
    } else if (n == 1) {
        return 1
    } else {
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
}

func fizz_buzz(n int) string {
    if (n % 15 == 0) {
        return "FizzBuzz"
    } else if (n % 5 == 0) {
        return "Buzz"
    } else if (n % 3 == 0) {
        return "Fizz"
    } else {
        return fmt.Sprintf("%d", n)
    }
}

