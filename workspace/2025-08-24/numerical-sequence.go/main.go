package main

import "fmt"
import "strings"

func main() {
    printSequence("factorials", factorial, 1, 10)
    printSequence("fibonacci numbers", fibonacci, 0, 20)
    printSequence("fizz buzz values", fizzBuzz, 1, 100)
}

func printSequence[T any](label string, f func(int) T, min int, max int) {
    xs := mapSlice(f, sequence(min, max))
    formattedXs := strings.Join(mapSlice(toString, xs), " ")
    fmt.Printf("%s:\n%s\n", label, formattedXs)
}

func sequence(min int, max int) []int {
    n := max - min + 1
    xs := make([]int, 0, n)

    for i := 0; i < n; i++ {
        xs = append(xs, min + i)
    }
    return xs
}

func mapSlice[T any, U any](f func(T) U, xs []T) []U {
    ys := make([]U, 0, len(xs))

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

func factorialTailrec(n int, fm int) int {
    if n == 0 {
        return fm
    }
    return factorialTailrec(n - 1, fm * n)
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

