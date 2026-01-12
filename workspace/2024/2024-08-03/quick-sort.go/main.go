package main

import (
    "cmp"
    "fmt"
    "math/rand"
    "strings"
)

func main() {
    xs := generateRandomValues(20)
    printSlice(xs)
    quickSort(xs)
    printSlice(xs)
}

func generateRandomValues(n int) []int {
    xs := make([]int, 0, n)

    for i := 0; i < n; i++ {
        xs = append(xs, rand.Intn(90) + 10)
    }
    return xs
}

func printSlice[T cmp.Ordered](xs []T) {
    s := strings.Join(mapSlice(toString, xs), " ")

    if isSorted(xs) {
        fmt.Printf("%s (sorted)\n", s)
    } else {
        fmt.Printf("%s (not sorted)\n", s)
    }
}

func toString[T any](x T) string {
    return fmt.Sprintf("%v", x)
}

func mapSlice[T any, U any](f func(T) U, xs []T) []U {
    ys := make([]U, 0, len(xs))

    for _, x := range xs {
        ys = append(ys, f(x))
    }
    return ys
}

func isSorted[T cmp.Ordered](xs []T) bool {
    for i := 0; i < len(xs) - 1; i++ {
        if xs[i] > xs[i + 1] {
            return false
        }
    }
    return true
}

func quickSort[T cmp.Ordered](xs []T) {
    quickSortRange(xs, 0, len(xs) - 1)
}

func quickSortRange[T cmp.Ordered](xs []T, lower int, upper int) {
    lessIndex := lower
    greaterIndex := upper
    pivot := xs[(lower + upper) / 2]

    for lessIndex <= greaterIndex {
        for xs[lessIndex] < pivot {
            lessIndex++
        }
        for xs[greaterIndex] > pivot {
            greaterIndex--
        }
        if lessIndex <= greaterIndex {
            xs[lessIndex], xs[greaterIndex] = xs[greaterIndex], xs[lessIndex]
            lessIndex++
            greaterIndex--
        }
    }

    if lower < greaterIndex {
        quickSortRange(xs, lower, greaterIndex)
    }
    if lessIndex < upper {
        quickSortRange(xs, lessIndex, upper)
    }
}

