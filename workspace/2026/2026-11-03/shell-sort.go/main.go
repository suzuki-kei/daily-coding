package main

import "fmt"
import "math/rand"
import "strings"

func main() {
    xs := generateRandomValues(20, 10, 100)
    printSlice(xs)
    shellSort(xs)
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

func shellSort(xs []int) {
    for gap := toInitialGap(len(xs)); 1 <= gap; gap /= 3 {
        for end := gap; end < len(xs); end++ {
            i := end
            value := xs[end]

            for gap <= i && value < xs[i - gap] {
                xs[i] = xs[i - gap]
                i -= gap
            }
            xs[i] = value
        }
    }
}

func toInitialGap(n int) int {
    gap := 1

    for gap * 3 + 1 < n {
        gap = gap * 3 + 1
    }

    return gap
}

