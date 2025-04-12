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
    incrementIndex := lower
    decrementIndex := upper
    pivot := randomSelectRange(xs, lower, upper)

    for incrementIndex <= decrementIndex {
        for xs[incrementIndex] < pivot {
            incrementIndex++
        }
        for xs[decrementIndex] > pivot {
            decrementIndex--
        }
        if incrementIndex <= decrementIndex {
            swap(xs, incrementIndex, decrementIndex)
            incrementIndex++
            decrementIndex--
        }
    }

    if lower < decrementIndex {
        quickSortRange(xs, lower, decrementIndex)
    }
    if incrementIndex < upper {
        quickSortRange(xs, incrementIndex, upper)
    }
}

func randomSelectRange[T any](xs []T, lower int, upper int) T {
    return xs[rand.Intn(upper - lower + 1) + lower]
}

func swap[T any](xs []T, index1 int, index2 int) {
    xs[index1], xs[index2] = xs[index2], xs[index1]
}

