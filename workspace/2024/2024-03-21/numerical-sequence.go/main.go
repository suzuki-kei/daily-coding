package main

import (
    "fmt"
    "strings"
)

func main() {
    printSequence("factorials", Factorial, 1, 10)
    printSequence("fibonacci numbers", Fibonacci, 0, 20)
    printSequence("fizz buzz values", FizzBuzz, 1, 100)
}

func printSequence[T any](description string, f func(int) T, min int, max int) {
    xs := mapSlice(f, sequence(min, max))
    s := strings.Join(mapSlice(toString, xs), " ")

    fmt.Printf("%s:\n%s\n", description, s)
}

func sequence(min int, max int) []int {
    var xs []int

    for i := min; i <= max; i++ {
        xs = append(xs, i)
    }
    return xs
}

func mapSlice[T any, U any](f func(T) U, xs []T) []U {
    var ys []U

    for _, x := range xs {
        ys = append(ys, f(x))
    }
    return ys
}

func toString[T any](x T) string {
    return fmt.Sprintf("%v", x)
}

func Factorial(n int) int {
    return factorial(n, 1)
}

func factorial(n int, accumulated int) int {
    if n == 0 {
        return accumulated
    }
    return factorial(n - 1, accumulated * n)
}

func Fibonacci(n int) int {
    return fibonacci(n, 0, 1)
}

func fibonacci(n int, a int, b int) int {
    if n == 0 {
        return a
    }
    return fibonacci(n - 1, b, a + b)
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

