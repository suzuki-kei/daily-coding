package stack

type Stack[T any] []T

func (s *Stack[T])IsEmpty() bool {
    return len(*s) == 0
}

func (s *Stack[T])Push(x T) {
    *s = append(*s, x)
}

func (s *Stack[T])Pop() {
    if len(*s) == 0 {
        // IGNORE
    } else {
        *s = (*s)[:len(*s)-1]
    }
}

