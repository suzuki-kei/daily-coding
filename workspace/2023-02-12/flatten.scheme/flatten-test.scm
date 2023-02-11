(use gauche.test)
(load "flatten")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test-flatten)))

(define test.flatten
    (lambda ()
        (test-start "flatten")
        (test* "#1" '() (flatten '()))
        (test* "#2" '(a) (flatten '(a)))
        (test* "#3" '(a b) (flatten '((a b))))
        (test* "#4" '(a b c) (flatten '(a (b) c)))
        (test* "#5" '(a b c d e) (flatten '(a (b) (((c) d) e))))
        (test-end)))

