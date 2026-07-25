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
    heapSort(xs)
    printSlice(xs)
}

func generateRandomValues(n int) []int {
    xs := make([]int, n)

    for i := 0; i < n; i++ {
        xs[i] = randomRange(10, 99)
    }

    return xs
}

func randomRange(min int, max int) int {
    return rand.Intn(max - min + 1) + min
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
    ys := make([]U, len(xs))

    for i, x := range xs {
        ys[i] = f(x)
    }

    return ys
}

func isSorted[T cmp.Ordered](xs []T) bool {
    for i := 0; i + 1 < len(xs); i++ {
        if xs[i] > xs[i + 1] {
            return false
        }
    }

    return true
}

func heapSort[T cmp.Ordered](xs []T) {
    makeHeap(xs)
    popAll(xs)
}

func makeHeap[T cmp.Ordered](xs []T) {
    for i := len(xs) / 2 - 1; i >= 0; i-- {
        shiftDown(xs, len(xs), i)
    }
}

func popAll[T cmp.Ordered](xs []T) {
    for i := len(xs) - 1; i >= 1; i-- {
        swap(&xs[i], &xs[0])
        shiftDown(xs, i, 0)
    }
}

func shiftDown[T cmp.Ordered](xs []T, n int, i int) {
    for i * 2 + 1 < n {
        maximumIndex := i
        leftIndex := i * 2 + 1
        rightIndex := i * 2 + 2

        if leftIndex < n && xs[leftIndex] > xs[maximumIndex] {
            maximumIndex = leftIndex
        }

        if rightIndex < n && xs[rightIndex] > xs[maximumIndex] {
            maximumIndex = rightIndex
        }

        if i == maximumIndex {
            break
        }

        swap(&xs[i], &xs[maximumIndex])
        i = maximumIndex
    }
}

func swap[T any](x1 *T, x2 *T) {
    *x1, *x2 = *x2, *x1
}

