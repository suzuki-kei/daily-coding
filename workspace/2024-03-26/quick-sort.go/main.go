package main

import (
    "cmp"
    "fmt"
    "math/rand"
    "strings"
    "time"
)

func main() {
    r := newRand()
    xs := generateRandomValues(20, r)

    printSlice(xs)
    quickSort(xs)
    printSlice(xs)
}

func newRand() *rand.Rand {
    return rand.New(rand.NewSource(time.Now().UnixNano()))
}

func generateRandomValues(n int, r *rand.Rand) []int {
    var xs []int

    for i := 0; i < n; i++ {
        xs = append(xs, r.Intn(90) + 10)
    }
    return xs
}

func printSlice[T cmp.Ordered](xs []T) {
    ys := mapSlice(toString, xs)
    s := strings.Join(ys, " ")

    if isSorted(xs) {
        fmt.Printf("%s (sorted)\n", s)
    } else {
        fmt.Printf("%s (not sorted)\n", s)
    }
}

func isSorted[T cmp.Ordered](xs []T) bool {
    for i := 0; i < len(xs) - 1; i++ {
        if xs[i] > xs[i + 1] {
            return false
        }
    }
    return true
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

func quickSort[T cmp.Ordered](xs []T) []T {
    return quickSortRange(xs, 0, len(xs) - 1)
}

func quickSortRange[T cmp.Ordered](xs []T, lower int, upper int) []T {
    var lowerIndex = lower
    var upperIndex = upper
    pivot := xs[(lower + upper) / 2]

    for lowerIndex <= upperIndex {
        for xs[lowerIndex] < pivot {
            lowerIndex++
        }
        for xs[upperIndex] > pivot {
            upperIndex--
        }
        if lowerIndex <= upperIndex {
            xs[lowerIndex], xs[upperIndex] = xs[upperIndex], xs[lowerIndex]
            lowerIndex++
            upperIndex--
        }
    }

    if lower < upperIndex {
        quickSortRange(xs, lower, upperIndex)
    }
    if lowerIndex < upper {
        quickSortRange(xs, lowerIndex, upper)
    }

    return xs
}

