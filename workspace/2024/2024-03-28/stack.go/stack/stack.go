package stack

import (
    "fmt"
    "stack.go/slices"
)

type Stack[T any] []T

func (s *Stack[T])IsEmpty() bool {
    return len(*s) == 0
}

func (s *Stack[T])ToString() string {
    return fmt.Sprintf("Stack[%T](%s)", *new(T), slices.ToString(*s, ", "))
}

func (s *Stack[T])Push(x T) {
    *s = append(*s, x)
}

func (s *Stack[T])Pop() {
    *s = (*s)[:len(*s)-1]
}

