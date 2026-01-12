package main

import (
    "fmt"
    "strings"
)

func main() {
    printSequence("factorials", factorial, 1, 10)
    printSequence("fibonacci numbers", fibonacci, 0, 20)
    printSequence("fizz buzz values", fizzBuzz, 1, 100)
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

func factorial(n int) int {
    return factorialTailrec(n, 1)
}

func factorialTailrec(n int, accumulated int) int {
    if n == 0 {
        return accumulated
    }
    return factorialTailrec(n - 1, accumulated * n)
}

func fibonacci(n int) int {
    return fibonacciTailrec(n, 0, 1)
}

func fibonacciTailrec(n int, a int, b int) int {
    if n == 0 {
        return a
    }
    return fibonacciTailrec(n - 1, b, a + b)
}

func fizzBuzz(n int) string {
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

