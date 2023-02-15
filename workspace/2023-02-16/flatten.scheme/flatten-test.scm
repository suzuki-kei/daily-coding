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
        (test* "#1" #t (atom? 1))
        (test* "#2" #t (atom? 'hello))
        (test* "#3" #f (atom? '()))
        (test* "#4" #f (atom? '(a b c)))
        (test-end)))

(define test.flatten
    (lambda ()
        (test-start "flatten")
        (test* "#1" '() (flatten '()))
        (test* "#2" '(a) (flatten '(a)))
        (test* "#3" '(a b) (flatten '(a b)))
        (test* "#4" '(a b c) (flatten '(a b c)))
        (test* "#5" '(a b c) (flatten '((a) ((b)) (((c))))))
        (test* "#6" '(a b c d e) (flatten '(a (b) ((c d) e))))
        (test-end)))

