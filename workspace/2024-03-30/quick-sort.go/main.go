package main

import (
    "cmp"
    "fmt"
    "math/rand"
)

func main() {
    xs := generateRandomValues(20)
    printSlice(xs)
    quickSort(xs)
    printSlice(xs)
}

func generateRandomValues(n int) []int {
    var xs = make([]int, 0, n)

    for i := 0; i < n; i++ {
        xs = append(xs, rand.Intn(90) + 10)
    }
    return xs
}

func printSlice[T cmp.Ordered](xs []T) {
    var separator = ""

    for _, x := range xs {
        fmt.Printf("%s%v", separator, x)
        separator = " "
    }

    if isSorted(xs) {
        fmt.Println(" (sorted)")
    } else {
        fmt.Println(" (not sorted)")
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

func quickSort[T cmp.Ordered](xs []T) {
    quickSortRange(xs, 0, len(xs) - 1)
}

func quickSortRange[T cmp.Ordered](xs []T, lower int, upper int) {
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
}

