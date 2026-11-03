package main

import "fmt"
import "math/rand"
import "strings"

func main() {
    xs := generateRandomValues(20, 10, 100)
    printSlice(xs)
    combSort(xs)
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

func combSort(xs []int) {
    gap := len(xs)
    swapped := false

    for {
        gap = toNextGap(gap)
        swapped = false

        for i := 0; i + gap < len(xs); i++ {
            if xs[i] > xs[i + gap] {
                swap(xs, i, i + gap)
            }
        }

        if gap == 1 && !swapped {
            break
        }
    }
}

func toNextGap(gap int) int {
    if gap <= 2 {
        return 1
    }
    if 13 <= gap && gap <= 15 {
        return 11
    }
    return gap * 10 / 13
}

func swap[T any](xs []T, index1 int, index2 int) {
    xs[index1], xs[index2] = xs[index2], xs[index1]
}

