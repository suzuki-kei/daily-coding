package slices

import (
    "fmt"
    "strings"
)

func Map[T any, U any](f func(T) U, xs []T) []U {
    ys := make([]U, 0, len(xs))

    for _, x := range xs {
        ys = append(ys, f(x))
    }
    return ys
}

func ToString[T any](xs []T, separator string) string {
    return strings.Join(Map(toString, xs), separator)
}

func toString[T any](x T) string {
    return fmt.Sprintf("%v", x)
}

