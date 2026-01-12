(use gauche.test)
(load "fold")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.sum)
        (test.product)))

(define test.sum
    (lambda ()
        (test-start "sum")
        (test* "#1" 0 (sum '()))
        (test* "#2" 1 (sum '(1)))
        (test* "#3" 3 (sum '(1 2)))
        (test* "#4" 6 (sum '(1 2 3)))
        (test-end)))

(define test.product
    (lambda ()
        (test-start "product")
        (test* "#1" 1 (product '()))
        (test* "#2" 1 (product '(1)))
        (test* "#4" 2 (product '(1 2)))
        (test* "#4" 6 (product '(1 2 3)))
        (test-end)))

