
(use gauche.test)
(load "fibonacci-number.scm")

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.fibonacci-number)))

(define test.fibonacci-number
    (lambda ()
        (test-start "fibonacci-number")
        (test* "#1" 1 (fibonacci-number 1))
        (test* "#2" 1 (fibonacci-number 2))
        (test* "#3" 2 (fibonacci-number 3))
        (test* "#4" 3 (fibonacci-number 4))
        (test* "#5" 5 (fibonacci-number 5))
        (test* "#6" 8 (fibonacci-number 6))
        (test* "#7" 13 (fibonacci-number 7))
        (test* "#8" 21 (fibonacci-number 8))
        (test* "#9" 34 (fibonacci-number 9))
        (test* "#10" 55 (fibonacci-number 10))
        (test-end)))

