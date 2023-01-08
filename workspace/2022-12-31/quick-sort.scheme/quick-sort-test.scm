
(use gauche.test)
(load "quick-sort.scm")

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.quick-sort)
        (test.partition)))

(define test.quick-sort
    (lambda ()
        (test-start "quick-sort")
        (test* "#1" '() (quick-sort '()))
        (test* "#2" '(1) (quick-sort '(1)))
        (test* "#3" '(1 2) (quick-sort '(2 1)))
        (test* "#4" '(1 2 3) (quick-sort '(2 1 3)))
        (test-end)))

(define test.partition
    (lambda ()
        (test-start "partition")
        (receive
            (less-xs equal-xs greater-xs)
            (partition 5 '(1 2 3 4 5 6 7 8 9))
            (test* "#1"
                '(#t #t #t)
                (list
                    (every (lambda (x) (< x 5)) less-xs)
                    (every (lambda (x) (= x 5)) equal-xs)
                    (every (lambda (x) (> x 5)) greater-xs))))
        (test-end)))

