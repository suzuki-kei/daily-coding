package main

import "fmt"
import "math/rand"
import "strings"

func main() {
    xs := generateRandomValues(20, 10, 100)
    printSlice(xs)
    heapSort(xs)
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

func heapSort(xs []int) {
    heapBuild(xs)
    heapPopAll(xs)
}

func heapBuild(xs []int) {
    for i := len(xs) / 2 - 1; 0 <= i; i-- {
        heapShiftDown(xs, len(xs), i)
    }
}

func heapPopAll(xs []int) {
    for i := len(xs) - 1; 1 <= i; i-- {
        swap(xs, i, 0)
        heapShiftDown(xs, i, 0)
    }
}

func heapShiftDown(xs []int, n int, i int) {
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

        swap(xs, i, maximumIndex)
        i = maximumIndex
    }
}

func swap[T any](xs []T, index1 int, index2 int) {
    xs[index1], xs[index2] = xs[index2], xs[index1]
}

