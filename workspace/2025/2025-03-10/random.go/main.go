package main

import (
    "fmt"
    "math/rand"
)

func main() {
    fmt.Println(generateRandomValues(20))
}

func generateRandomValues(n int) []int {
    xs := make([]int, 0, n)

    for i := 0; i < n; i++ {
        xs = append(xs, rand.Intn(90) + 10)
    }
    return xs
}

