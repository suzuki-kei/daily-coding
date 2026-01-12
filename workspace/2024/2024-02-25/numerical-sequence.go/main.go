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
    return factorial_tailrec(n, 1)
}

func factorial_tailrec(n int, accumulated int) int {
    switch n {
        case 0:
            return accumulated
        default:
            return factorial_tailrec(n - 1, accumulated * n)
    }
}

func fibonacci(n int) int {
    return fibonacci_tailrec(n, 0, 1)
}

func fibonacci_tailrec(n int, a int, b int) int {
    switch n {
        case 0:
            return a
        default:
            return fibonacci_tailrec(n - 1, b, a + b)
    }
}

func fizz_buzz(n int) string {
    if (n % 15 == 0) {
        return "FizzBuzz"
    }
    if (n % 5 == 0) {
        return "Buzz"
    }
    if (n % 3 == 0) {
        return "Fizz"
    }
    return fmt.Sprintf("%d", n)
}

