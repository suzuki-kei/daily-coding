package main

import (
    "fmt"
    "localhost/stack"
)

func main() {
    var s stack.Stack[int]
    fmt.Println(s)

    for i := 0; i < 10; i++ {
        s.Push(i)
        fmt.Println(s)
    }

    for !s.IsEmpty() {
        s.Pop()
        fmt.Println(s)
    }
}

