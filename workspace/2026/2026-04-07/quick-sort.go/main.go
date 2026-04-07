package main

import "cmp"
import "fmt"
import "math/rand"
import "strings"

type PartitionResult struct {
    LeftUpper int
    RightLower int
}

type Partition func([]int, int, int) PartitionResult

func main() {
    demonstration("partition 2-way", partition2Way)
    demonstration("partition 3-way", partition3Way)
}

func demonstration(label string, partition Partition) {
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

func printSlice[T cmp.Ordered](xs []T) {
    s := strings.Join(mapSlice(toString, xs), " ")

    if isSorted(xs) {
        fmt.Printf("%s (sorted)\n", s)
    } else {
        fmt.Printf("%s (not sorted)\n", s)
    }
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

func isSorted[T cmp.Ordered](xs []T) bool {
    for i := 0; i < len(xs) - 1; i++ {
        if xs[i] > xs[i + 1] {
            return false
        }
    }

    return true
}

func quickSort(xs []int, partition Partition) {
    if len(xs) <= 1 {
        return
    }

    quickSortRange(xs, 0, len(xs) - 1, partition)
}

func quickSortRange(xs []int, lower int, upper int, partition Partition) {
    if lower >= upper {
        return
    }

    result := partition(xs, lower, upper)
    quickSortRange(xs, lower, result.LeftUpper, partition)
    quickSortRange(xs, result.RightLower, upper, partition)
}

func partition2Way(xs []int, lower int, upper int) PartitionResult {
    incrementIndex := lower
    decrementIndex := upper
    pivot := randomSelect(xs, lower, upper)

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

    return PartitionResult {
        LeftUpper: decrementIndex,
        RightLower: incrementIndex,
    }
}

func partition3Way(xs []int, lower int, upper int) PartitionResult {
    lessEnd := lower
    incrementIndex := lower
    decrementIndex := upper
    pivot := randomSelect(xs, lower, upper)

    for incrementIndex <= decrementIndex {
        if xs[incrementIndex] < pivot {
            swap(xs, lessEnd, incrementIndex)
            lessEnd++
            incrementIndex++
        } else if xs[incrementIndex] > pivot {
            swap(xs, incrementIndex, decrementIndex)
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

func randomSelect[T any](xs []T, lower int, upper int) T {
    return xs[rand.Intn((upper - lower + 1)) + lower]
}

func swap[T any](xs []T, index1 int, index2 int) {
    xs[index1], xs[index2] = xs[index2], xs[index1]
}

