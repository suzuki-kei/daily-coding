package main

import "cmp"
import "fmt"
import "math/rand"
import "strings"

type PartitionResult struct {
    LeftUpper int
    RightLower int
}

type Partition[T cmp.Ordered] func([]T, int, int) PartitionResult

func main() {
    demonstration("partition 2-way", partition2Way)
    demonstration("partition 3-way", partition3Way)
}

func demonstration(label string, partition Partition[int]) {
    fmt.Printf("==== %s\n", label)
    xs := generateRandomValues(20)
    printSlice(xs)
    quickSort(xs, partition)
    printSlice(xs)
}

func generateRandomValues(n int) []int {
    xs := make([]int, 0, n)

    for i := 0; i < n; i++ {
        xs = append(xs, rand.Intn(90) + 10)
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

func quickSort[T cmp.Ordered](xs []T, partition Partition[T]) {
    if len(xs) <= 1 {
        return
    }

    quickSortRange(xs, 0, len(xs) - 1, partition)
}

func quickSortRange[T cmp.Ordered](xs []T, lower int, upper int, partition Partition[T]) {
    if lower >= upper {
        return
    }

    result := partition(xs, lower, upper)
    quickSortRange(xs, lower, result.LeftUpper, partition)
    quickSortRange(xs, result.RightLower, upper, partition)
}

func partition2Way[T cmp.Ordered](xs []T, lower int, upper int) PartitionResult {
    incrementIndex := lower
    decrementIndex := upper
    pivot := xs[randomRange(lower, upper)]

    for incrementIndex <= decrementIndex {
        for xs[incrementIndex] < pivot {
            incrementIndex++
        }
        for xs[decrementIndex] > pivot {
            decrementIndex--
        }
        if incrementIndex <= decrementIndex {
            swap(&xs[incrementIndex], &xs[decrementIndex])
            incrementIndex++
            decrementIndex--
        }
    }

    return PartitionResult {
        LeftUpper: decrementIndex,
        RightLower: incrementIndex,
    }
}

func partition3Way[T cmp.Ordered](xs []T, lower int, upper int) PartitionResult {
    lessEnd := lower
    incrementIndex := lower
    decrementIndex := upper
    pivot := xs[randomRange(lower, upper)]

    for incrementIndex <= decrementIndex {
        if xs[incrementIndex] < pivot {
            swap(&xs[lessEnd], &xs[incrementIndex])
            lessEnd++
            incrementIndex++
        } else if xs[incrementIndex] > pivot {
            swap(&xs[incrementIndex], &xs[decrementIndex])
            decrementIndex--
        } else {
            incrementIndex++
        }
    }

    return PartitionResult {
        LeftUpper: lessEnd - 1,
        RightLower: incrementIndex,
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

