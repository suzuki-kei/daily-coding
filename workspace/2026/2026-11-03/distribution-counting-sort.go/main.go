package main

import "fmt"
import "math/rand"
import "strings"

func main() {
    valueBegin := 0
    valueEnd := 10
    xs := generateRandomValues(20, valueBegin, valueEnd)
    printSlice(xs)
    distributionCountingSort(xs, valueBegin, valueEnd)
    printSlice(xs)
}

func generateRandomValues(n int, begin int, end int) []int {
    xs := make([]int, n)

    for i := 0; i < n; i++ {
        xs[i] = randomRange(begin, end)
    }

    return xs
}

func randomRange(begin int, end int) int {
    return rand.Intn(end - begin) + begin
}

func printSlice(xs []int) {
    s := strings.Join(mapSlice(toString, xs), " ")

    if isSorted(xs) {
        fmt.Printf("%s (sorted)\n", s)
    } else {
        fmt.Printf("%s (not sorted)\n", s)
    }
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

func isSorted(xs []int) bool {
    for i := 0; i + 1 < len(xs); i++ {
        if xs[i] > xs[i + 1] {
            return false
        }
    }

    return true
}

func distributionCountingSort(xs []int, valueBegin int, valueEnd int) {
    buffer := make([]int, len(xs))
    nCounts := valueEnd - valueBegin
    counts := make([]int, nCounts)

    for i := 0; i < len(xs); i++ {
        counts[xs[i] - valueBegin]++
    }

    for i := 1; i < nCounts; i++ {
        counts[i] += counts[i - 1]
    }

    for i := len(xs) - 1; 0 <= i; i-- {
        iCounts := xs[i] - valueBegin
        buffer[counts[iCounts] - 1] = xs[i]
        counts[iCounts]--
    }

    copy(xs, buffer)
}

func swap[T any](xs []T, index1 int, index2 int) {
    xs[index1], xs[index2] = xs[index2], xs[index1]
}

