package main

import "cmp"
import "fmt"
import "math/rand"
import "strings"

func main() {
    xs := generateRandomValues(20)
    printSlice(xs)
    shellSort(xs)
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

func shellSort[T cmp.Ordered](xs []T) {
    for hop := computeInitialHop(len(xs)); hop >= 1; hop /= 3 {
        for i := hop; i < len(xs); i++ {
            insert(xs, i, hop)
        }
    }
}

func computeInitialHop(n int) int {
    hop := 1

    for hop * 3 + 1 < n {
        hop = hop * 3 + 1
    }

    return hop
}

func insert[T cmp.Ordered](xs []T, i int, hop int) {
    value := xs[i]

    for i >= hop && value < xs[i - hop] {
        xs[i] = xs[i - hop]
        i -= hop
    }

    xs[i] = value
}

func randomRange(min int, max int) int {
    return rand.Intn(max - min + 1) + min
}

