package main

import (
    "fmt"
    "time"
)

func main() {
    go PrintTickInfinite()

    c := make(chan int)
    go Factorial(15, c)
    go Factorial(10, c)

    value1 := <-c
    value2 := <-c
    fmt.Println(value1, value2)
}

func PrintTickInfinite() {
    for i := 0; true; i++ {
        fmt.Printf("tick... %d\n", i)
        time.Sleep(100 * time.Millisecond)
    }
}

func Factorial(n int, c chan int) {
    FactorialTailrec(n, c, 1)
}

func FactorialTailrec(n int, c chan int, accumulated int) {
    if n == 0 {
        c <- accumulated
    }

    time.Sleep(100 * time.Millisecond)
    FactorialTailrec(n - 1, c, accumulated * n)
}

