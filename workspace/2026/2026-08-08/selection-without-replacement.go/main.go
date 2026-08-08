package main

import (
    "fmt"
    "math/rand"
    "strings"
)

func main() {
    xs := selectionWithoutReplacement(10, 99, 20)
    printSlice(xs)
}

func selectionWithoutReplacement(min int, max int, n int) []int {
    xs := make([]int, 0, n)

    for value := min; len(xs) < n && value <= max; value++ {
        numerator := float64(n - len(xs))
        denominator := float64(max - value + 1)
        r := rand.Float64()

        if r < numerator / denominator {
            xs = append(xs, value)
        }
    }

    return xs
}

func printSlice(xs []int) {
    s := strings.Join(mapSlice(toString, xs), " ")
    fmt.Println(s)
}

func mapSlice[T any, U any](f func(T) U, xs []T) []U {
    ys := make([]U, len(xs))

    for i, x := range xs {
        ys[i] = f(x)
    }

    return ys
}

func toString[T any](x T) string {
    return fmt.Sprintf("%v", x)
}

