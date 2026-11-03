package main

import "fmt"
import "math/rand"
import "strings"

func main() {
    xs := generateRandomValues(20, 10, 100)
    printSlice(xs)
    mergeSort(xs)
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

func mergeSort(xs []int) {
    buffer := make([]int, len(xs))
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

        input, output = output, input
    }

    if &xs == output {
        copy(xs, buffer)
    }
}

func merge(output []int, outputIndex int, input []int, begin1 int, end1 int, begin2 int, end2 int) {
    for begin1 < end1 && begin2 < end2 {
        if input[begin1] <= input[begin2] {
            output[outputIndex] = input[begin1]
            begin1++
            outputIndex++
        } else {
            output[outputIndex] = input[begin2]
            begin2++
            outputIndex++
        }
    }

    for begin1 < end1 {
        output[outputIndex] = input[begin1]
        begin1++
        outputIndex++
    }

    for begin2 < end2 {
        output[outputIndex] = input[begin2]
        begin2++
        outputIndex++
    }
}

