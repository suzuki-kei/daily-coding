package main

import "fmt"

func main() {
    PrintSequence("factorials", Factorial, 1, 10)
    PrintSequence("fibonacci numbers", Fibonacci, 0, 20)
    PrintSequence("fizz buzz values", FizzBuzz, 1, 100)
}

func PrintSequence[T any](description string, f func(int) T, min int, max int) {
    fmt.Printf("%s:\n", description)

    var separator = ""
    for i := min; i <= max; i++ {
        fmt.Print(separator, f(i))
        separator = " "
    }
    fmt.Println()
}

func Factorial(n int) int {
    return FactorialTailrec(n, 1)
}

func FactorialTailrec(n int, accumulator int) int {
    if n == 0 {
        return accumulator
    }
    return FactorialTailrec(n - 1, accumulator * n)
}

func Fibonacci(n int) int {
    return FibonacciTailrec(n, 0, 1)
}

func FibonacciTailrec(n int, a int, b int) int {
    if n == 0 {
        return a
    }
    return FibonacciTailrec(n - 1, b, a + b)
}

func FizzBuzz(n int) string {
    if n % 15 == 0 {
        return "FizzBuzz"
    }
    if n % 5 == 0 {
        return "Buzz"
    }
    if n % 3 == 0 {
        return "Fizz"
    }
    return fmt.Sprintf("%d", n)
}

