package main

import "cmp"
import "fmt"
import "math/rand"
import "strings"

func main() {
    xs := selectionWithoutReplacement(10, 100, 20)
    fmt.Println(strings.Join(mapSlice(toString, xs), " "))

    min := xs[0] - 1
    max := xs[len(xs) - 1] + 1

    for target := min; target <= max; target++ {
        index := binarySearch(xs, target)
        fmt.Printf("target = %d, index = %d\n", target, index)
    }
}

func selectionWithoutReplacement(begin int, end int, n int) []int {
    xs := make([]int, 0, n)

    for x := begin; x < end; x++ {
        nRemaining := n - len(xs)
        nCandidatesRemaining := end - x
        selectionProbability := float64(nRemaining) / float64(nCandidatesRemaining)

        if rand.Float64() < selectionProbability {
            xs = append(xs, x)
        }
    }

    return xs
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

func binarySearch[T cmp.Ordered](xs []T, target T) int {
    return binarySearchRange(xs, target, 0, len(xs) - 1)
}

func binarySearchRange[T cmp.Ordered](xs []T, target T, first int, last int) int {
    if first > last {
        return -1
    }

    center := (first + last) / 2

    if target == xs[center] {
        return center
    }

    if target < xs[center] {
        return binarySearchRange(xs, target, first, center - 1)
    } else {
        return binarySearchRange(xs, target, center + 1, last)
    }
}

