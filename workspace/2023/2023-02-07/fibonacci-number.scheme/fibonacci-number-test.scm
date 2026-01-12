(use gauche.test)
(load "fibonacci-number")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.fibonacci)))

(define test.fibonacci
    (lambda ()
        (test-start "fibonacci")
        (test* "#1" 0 (fibonacci 0))
        (test* "#2" 1 (fibonacci 1))
        (test* "#3" 1 (fibonacci 2))
        (test* "#4" 2 (fibonacci 3))
        (test* "#5" 3 (fibonacci 4))
        (test* "#6" 5 (fibonacci 5))
        (test* "#7" 8 (fibonacci 6))
        (test* "#8" 13 (fibonacci 7))
        (test* "#9" 21 (fibonacci 8))
        (test* "#10" 34 (fibonacci 9))
        (test-end)))

