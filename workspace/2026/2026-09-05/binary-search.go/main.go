package main

import "cmp"
import "fmt"
import "math/rand"
import "strings"

func main() {
    xs := selectionWithoutReplacement(10, 99, 20)
    fmt.Println(strings.Join(mapSlice(toString, xs), " "))

    minTarget := xs[0] - 1
    maxTarget := xs[len(xs) - 1] + 1

    for target := minTarget; target <= maxTarget; target++ {
        index := binarySearch(xs, target)
        fmt.Printf("target = %d, index = %d\n", target, index)
    }
}

func selectionWithoutReplacement(min int, max int, n int) []int {
    xs := make([]int, 0, n)

    for x := min; x <= max; x++ {
        nRemaining := n - len(xs)
        nCandidatesRemaining := max - x + 1
        selectionProbability := float64(nRemaining) / float64(nCandidatesRemaining)

        if rand.Float64() < selectionProbability {
            xs = append(xs, x)
        }
    }

    return xs
}

func mapSlice[T any, U any](f func(T) U, xs []T) []U {
    ys := make([]U, 0, len(xs))

    for _, x := range xs {
        ys = append(ys, f(x))
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

