package main

import "cmp"
import "fmt"
import "math/rand"
import "strings"

func main() {
    xs := generateRandomValues(20)
    printSlice(xs)
    selectionSort(xs)
    printSlice(xs)
}

func generateRandomValues(n int) []int {
    xs := make([]int, 0, n)

    for i := 0; i < n; i++ {
        xs = append(xs, randomRange(10, 99))
    }

    return xs
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

func isSorted[T cmp.Ordered](xs []T) bool {
    for i := 0; i + 1 < len(xs); i++ {
        if xs[i] > xs[i + 1] {
            return false
        }
    }

    return true
}

func selectionSort[T cmp.Ordered](xs []T) {
    for begin := 0; begin + 1 < len(xs); begin++ {
        minimumIndex := begin

        for i := begin + 1; i < len(xs); i++ {
            if xs[i] < xs[minimumIndex] {
                minimumIndex = i
            }
        }
        swap(&xs[begin], &xs[minimumIndex])
    }
}

func randomRange(min int, max int) int {
    return rand.Intn(max - min + 1) + min
}

func swap[T any](x1 *T, x2 *T) {
    temporary := *x1
    *x1 = *x2
    *x2 = temporary
}

