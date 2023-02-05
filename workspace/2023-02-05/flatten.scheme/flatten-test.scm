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
        (test* "#1" #t (atom? #t))
        (test* "#2" #t (atom? 0))
        (test* "#3" #t (atom? 1.5))
        (test* "#4" #t (atom? 2/3))
        (test* "#5" #t (atom? 'a))
        (test* "#6" #t (atom? "hello"))
        (test* "#7" #f (atom? '()))
        (test* "#8" #f (atom? '(a . b)))
        (test* "#9" #f (atom? '(a (b c) (((d) e) f) g)))
        (test-end)))

(define test.flatten
    (lambda ()
        (test-start "flatten")
        (test* "#1" #t (flatten #t))
        (test* "#2" 0 (flatten 0))
        (test* "#3" 1.5 (flatten 1.5))
        (test* "#4" 2/3 (flatten 2/3))
        (test* "#5" 'a (flatten 'a))
        (test* "#6" "hello" (flatten "hello"))
        (test* "#7" '() (flatten '()))
        (test* "#8" '(a . b) (flatten '(a . b)))
        (test* "#9" '(a b c d e f g) (flatten '(a (b c) (((d) e) f) g)))
        (test-end)))

