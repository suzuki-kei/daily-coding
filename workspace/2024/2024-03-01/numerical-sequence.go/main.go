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
    var values []int

    for i := min; i <= max; i++ {
        values = append(values, i)
    }

    return values
}

func Map[T any, U any](f func(T) U, values []T) []U {
    var mappedValues []U

    for _, value := range values {
        mappedValues = append(mappedValues, f(value))
    }

    return mappedValues
}

func ToString[T any](value T) string {
    return fmt.Sprintf("%v", value)
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

