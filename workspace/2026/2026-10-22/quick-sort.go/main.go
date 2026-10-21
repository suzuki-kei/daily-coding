package main

import "fmt"
import "math/rand"
import "strings"

type Range struct {
    Begin int
    End int
}

type Partition func(xs []int, begin int, end int) Range

func main() {
    demonstration("partition 2-way", partition2Way)
    demonstration("partition 3-way", partition3Way)
}

func demonstration(label string, partition Partition) {
    fmt.Printf("==== %s\n", label)
    xs := generateRandomValues(20, 10, 100)
    printSlice(xs)
    quickSort(xs, partition)
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

func quickSort(xs []int, partition Partition) {
    quickSortRange(xs, 0, len(xs), partition)
}

func quickSortRange(xs []int, begin int, end int, partition Partition) {
    for begin < end - 1 {
        middle := partition(xs, begin, end)
        nLeft := middle.Begin - begin
        nRight := end - middle.End

        if nLeft < nRight {
            quickSortRange(xs, begin, middle.Begin, partition)
            begin = middle.End
        } else {
            quickSortRange(xs, middle.End, end, partition)
            end = middle.Begin
        }
    }
}

func partition2Way(xs []int, begin int, end int) Range {
    incrementIndex := begin
    decrementIndex := end - 1
    pivot := xs[randomRange(begin, end)]

    for incrementIndex <= decrementIndex {
        for xs[incrementIndex] < pivot {
            incrementIndex++
        }

        for xs[decrementIndex] > pivot {
            decrementIndex--
        }

        if incrementIndex <= decrementIndex {
            swap(xs, incrementIndex, decrementIndex)
            incrementIndex++
            decrementIndex--
        }
    }

    return Range {
        Begin: decrementIndex + 1,
        End: incrementIndex,
    }
}

func partition3Way(xs []int, begin int, end int) Range {
    i := begin
    lessEnd := begin
    greaterBegin := end
    pivot := xs[randomRange(begin, end)]

    for i < greaterBegin {
        if xs[i] < pivot {
            swap(xs, lessEnd, i)
            lessEnd++
            i++
        } else if xs[i] > pivot {
            swap(xs, i, greaterBegin - 1)
            greaterBegin--
        } else {
            i++
        }
    }

    return Range {
        Begin: lessEnd,
        End: greaterBegin,
    }
}

func swap[T any](xs []T, index1 int, index2 int) {
    xs[index1], xs[index2] = xs[index2], xs[index1]
}

