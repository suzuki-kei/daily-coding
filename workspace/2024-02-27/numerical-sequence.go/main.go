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

    for _, v := range values {
        mappedValues = append(mappedValues, f(v))
    }

    return mappedValues
}

func ToString[T any](x T) string {
    return fmt.Sprintf("%v", x)
}

func Factorial(n int) int {
    return FactorialTailrec(n, 1)
}

func FactorialTailrec(n int, accumulated int) int {
    if n == 0 {
        return accumulated
    }
    return FactorialTailrec(n - 1, accumulated * n)
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

