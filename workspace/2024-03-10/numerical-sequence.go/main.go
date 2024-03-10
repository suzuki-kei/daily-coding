package main

import (
    "fmt"
    "strings"
)

func main() {
    PrintSequence("factorials", Factorial, 1, 10)
    PrintSequence("fibonacci numbers", Fibonacci, 0, 20)
    PrintSequence("fizz buzz values", FizzBuzz, 1, 100)
}

func PrintSequence[T any](description string, f func(int) T, min int, max int) {
    values := Map(f, Sequence(min, max))
    string := strings.Join(Map(ToString, values), " ")

    fmt.Printf("%s:\n%s\n", description, string)
}

func Sequence(min int, max int) []int {
    var xs []int

    for i := min; i <= max; i++ {
        xs = append(xs, i)
    }
    return xs
}

func Map[T any, U any](f func(T) U, xs []T) []U {
    var ys []U

    for _, x := range xs {
        ys = append(ys, f(x))
    }
    return ys
}

func ToString[T any](x T) string {
    return fmt.Sprintf("%v", x)
}

func Factorial(n int) int {
    if n == 0 {
        return 1
    }
    return n * Factorial(n - 1)
}

func Fibonacci(n int) int {
    if n == 0 {
        return 0
    }
    if n == 1 {
        return 1
    }
    return Fibonacci(n - 1) + Fibonacci(n - 2)
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

