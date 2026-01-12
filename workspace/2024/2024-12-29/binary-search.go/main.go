package main

import (
    "cmp"
    "fmt"
    "math/rand"
    "strings"
)

func main() {
    xs := generateRandomAscendingValues(20)
    fmt.Println(strings.Join(mapSlice(toString, xs), " "))

    lower := xs[0] - 1
    upper := xs[len(xs) - 1] + 1

    for target := lower; target <= upper; target++ {
        index := binarySearch(xs, target)
        fmt.Printf("target=%d, index=%d\n", target, index)
    }
}

func generateRandomAscendingValues(n int) []int {
    x := 9
    xs := make([]int, 0, n)

    for i := 0; i < n; i++ {
        x += rand.Intn(5) + 1
        xs = append(xs, x)
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

func binarySearch[T cmp.Ordered](xs []T, target T) int {
    return binarySearchRange(xs, target, 0, len(xs) - 1)
}

func binarySearchRange[T cmp.Ordered](xs []T, target T, lower int, upper int) int {
    if (lower > upper) {
        return -1
    }

    center := (lower + upper) / 2

    if (target == xs[center]) {
        return center
    }

    if (target < xs[center]) {
        return binarySearchRange(xs, target, lower, center - 1)
    } else {
        return binarySearchRange(xs, target, center + 1, upper)
    }
}

