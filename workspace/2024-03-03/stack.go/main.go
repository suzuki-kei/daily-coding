package main

import (
    "fmt"
)

func main() {
    fmt.Println("OK")

    stack := NewStack(10)
    fmt.Println(stack.ToString(), stack.IsEmpty())

    for i := 0; i < 10; i++ {
        stack.Push(i)
        fmt.Println(stack.ToString(), stack.IsEmpty())
    }

    for !stack.IsEmpty() {
        stack.Pop()
        fmt.Println(stack.ToString(), stack.IsEmpty())
    }
}

type Stack struct {
    data []int
    size int
}

func NewStack(capacity int) *Stack {
    return &Stack {
        data: make([]int, 0, capacity),
        size: 0,
    }
}

func (stack *Stack) IsEmpty() bool {
    return stack.size == 0
}

func (stack *Stack) Top() int {
    return stack.data[stack.size - 1]
}

func (stack *Stack) Push(value int) {
    stack.data = append(stack.data, value)
    stack.size++
}

func (stack *Stack) Pop() {
    stack.data = stack.data[:stack.size - 1]
    stack.size--
}

func (stack *Stack) ToString() string {
    return fmt.Sprint(stack.data)
}

