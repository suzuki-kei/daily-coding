package main

import (
    "cmp"
    "fmt"
    "math/rand"
    "strings"
)

func main() {
    xs := generateRandomAscendingValues(20)
    printSlice(xs)

    lower := xs[0] - 1
    upper := xs[len(xs) - 1] + 1

    for target := lower; target <= upper; target++ {
        index := binarySearch(xs, target)
        fmt.Printf("target=%d, index=%d\n", target, index)
    }
}

func generateRandomAscendingValues(n int) []int {
    var xs = make([]int, 0, n)
    var value = 9

    for i := 0; i < n; i++ {
        value += rand.Intn(5) + 1
        xs = append(xs, value)
    }
    return xs
}

func printSlice[T cmp.Ordered](xs []T) {
    s := strings.Join(mapSlice(toString, xs), " ")
    fmt.Println(s)
}

func toString[T any](x T) string {
    return fmt.Sprintf("%v", x)
}

func mapSlice[T any, U any](f func(T) U, xs []T) []U {
    var ys = make([]U, 0, len(xs))

    for _, x := range xs {
        ys = append(ys, f(x))
    }
    return ys
}

func binarySearch[T cmp.Ordered](xs []T, target T) int {
    return binarySearchRange(xs, target, 0, len(xs) - 1)
}

func binarySearchRange[T cmp.Ordered](xs []T, target T, lower int, upper int) int {
    if lower > upper {
        return -1
    }

    center := (lower + upper) / 2

    if target < xs[center] {
        return binarySearchRange(xs, target, lower, center - 1)
    }
    if target > xs[center] {
        return binarySearchRange(xs, target, center + 1, upper)
    }
    return center
}

