package main

import "cmp"
import "fmt"
import "math/rand"
import "strings"

func main() {
    xs := selectionWithoutReplacement(20, 10, 100)
    fmt.Println(strings.Join(mapSlice(toString, xs), " "))

    minTarget := xs[0] - 1
    maxTarget := xs[len(xs) - 1] + 1

    for target := minTarget; target <= maxTarget; target++ {
        index := binarySearch(xs, target)
        fmt.Printf("target = %d, index = %d\n", target, index)
    }
}

func selectionWithoutReplacement(n int, begin int, end int) []int {
    xs := make([]int, 0, n)

    for value := begin; value < end; value++ {
        nRemaining := n - len(xs)
        nCandidatesRemainings := end - value
        selectionProbability := float64(nRemaining) / float64(nCandidatesRemainings)

        if rand.Float64() < selectionProbability {
            xs = append(xs, value)
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
    return binarySearchRange(xs, target, 0, len(xs))
}

func binarySearchRange[T cmp.Ordered](xs []T, target T, begin int, end int) int {
    if begin >= end {
        return -1
    }

    center := (begin + end - 1) / 2

    if target == xs[center] {
        return center
    }

    if target < xs[center] {
        return binarySearchRange(xs, target, begin, center)
    } else {
        return binarySearchRange(xs, target, center + 1, end)
    }
}

