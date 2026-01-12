package main

import (
    "bufio"
    "fmt"
    "os"
)

import (
    "golang.org/x/crypto/ssh/terminal"
)

func main() {
    for _, x := range os.Args[1:] {
        fmt.Println(x)
    }

    if !terminal.IsTerminal(int(os.Stdin.Fd())) {
        s := bufio.NewScanner(os.Stdin)

        for s.Scan() {
            fmt.Println(s.Text())
        }
    }
}

