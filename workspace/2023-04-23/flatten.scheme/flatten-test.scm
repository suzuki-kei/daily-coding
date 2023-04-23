(use gauche.test)
(load "flatten")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.atom?)
        (test.flatten)))

(define test.atom?
    (lambda ()
        (test-start "atom?")
        (test* "#1" #t (atom? 0))
        (test* "#2" #t (atom? #t))
        (test* "#3" #t (atom? 'abc))
        (test* "#4" #f (atom? '()))
        (test* "#5" #f (atom? '(a (b c))))
        (test-end)))

(define test.flatten
    (lambda ()
        (test-start "flatten")
        (test* "#1" '() (flatten '()))
        (test* "#2" '(a) (flatten 'a))
        (test* "#3" '(a) (flatten '(a)))
        (test* "#4" '(a b c d e) (flatten '((a) (b c) ((d e)))))
        (test* "#5" '(a b c d e) (flatten '(a (b) ((c d) e))))
        (test-end)))

