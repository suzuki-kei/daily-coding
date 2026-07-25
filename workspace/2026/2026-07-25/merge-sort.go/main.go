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
    mergeSort(xs)
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

func mergeSort[T cmp.Ordered](xs []T) {
    buffer := make([]T, len(xs))
    input := &xs
    output := &buffer

    for chunkSize := 1; chunkSize < len(xs); chunkSize *= 2 {
        for i := 0; i < len(xs); i += chunkSize * 2 {
            merge(
                *output,
                i,
                *input,
                i,
                min(len(xs), i + chunkSize),
                min(len(xs), i + chunkSize),
                min(len(xs), i + chunkSize * 2))
        }

        swap(&input, &output)
    }

    if &xs == output {
        for i, x := range buffer {
            xs[i] = x
        }
    }
}

func merge[T cmp.Ordered](output []T, outputIndex int, input []T, begin1 int, end1 int, begin2 int, end2 int) {
    for begin1 != end1 && begin2 != end2 {
        if input[begin1] <= input[begin2] {
            output[outputIndex] = input[begin1]
            outputIndex++
            begin1++
        } else {
            output[outputIndex] = input[begin2]
            outputIndex++
            begin2++
        }
    }

    for begin1 != end1 {
        output[outputIndex] = input[begin1]
        outputIndex++
        begin1++
    }

    for begin2 != end2 {
        output[outputIndex] = input[begin2]
        outputIndex++
        begin2++
    }
}

func swap[T any](x1 *T, x2 *T) {
    *x1, *x2 = *x2, *x1
}

