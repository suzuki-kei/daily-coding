package main

import (
    "fmt"
    "stack.go/stack"
)

func main() {
    var s stack.Stack[int]
    fmt.Println(s.ToString())

    for i := 0; i < 10; i++ {
        s.Push(i)
        fmt.Println(s.ToString())
    }

    for !s.IsEmpty() {
        s.Pop()
        fmt.Println(s.ToString())
    }
}

