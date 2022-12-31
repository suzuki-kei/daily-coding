
(use gauche.test)
(load "merge-sort.scm")

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.merge-sort)
        (test.merge)))

(define test.merge-sort
    (lambda ()
        (test-start "merge-sort")
        (test* "#1" '() (merge-sort '()))
        (test* "#2" '(1) (merge-sort '(1)))
        (test* "#3" '(1 2) (merge-sort '(2 1)))
        (test* "#4" '(1 2 3) (merge-sort '(2 1 3)))
        (test-end)))

(define test.merge
    (lambda ()
        (test-start "merge")
        (test* "#1" '() (merge '() '()))
        (test* "#2" '(1) (merge '(1) '()))
        (test* "#3" '(1) (merge '() '(1)))
        (test* "#4" '(1 2 3 4 5) (merge '(1 2 5) '(3 4)))
        (test-end)))

