(use gauche.test)
(load "permutations-combinations")

(define main
    (lambda (arguents)
        (test-all)))

(define test-all
    (lambda ()
        (test.atom?)
        (test.flatten?)
        (test.flatten)
        (test.remove-nth)
        (test.permutations)
        (test.combinations)))

(define test.atom?
    (lambda ()
        (test-start "atom?")
        (test* "#1" #t (atom? 1))
        (test* "#2" #f (atom? '()))
        (test* "#3" #f (atom? '(a b c)))
        (test-end)))

(define test.flatten?
    (lambda ()
        (test-start "flatten?")
        (test* "#1" #t (flatten? 1))
        (test* "#2" #t (flatten? '()))
        (test* "#3" #t (flatten? '(a b c)))
        (test* "#4" #f (flatten? '(a (b) c)))
        (test-end)))

(define test.flatten
    (lambda ()
        (test-start "flatten")
        (test* "#1" '() (flatten '() atom?))
        (test* "#2" '(a) (flatten '(a) atom?))
        (test* "#3" '(a b) (flatten '(a b) atom?))
        (test* "#4" '(a b c) (flatten '(a b c) atom?))
        (test* "#5" '(a b c) (flatten '(a (b) c) atom?))
        (test-end)))

(define test.remove-nth
    (lambda ()
        (test-start "remove-nth")
        (test* "#1"
            '((b c) a)
            (receive (ys x) (remove-nth '(a b c) 0) (list ys x)))
        (test* "#2"
            '((a c) b)
            (receive (ys x) (remove-nth '(a b c) 1) (list ys x)))
        (test* "#3"
            '((a b) c)
            (receive (ys x) (remove-nth '(a b c) 2) (list ys x)))
        (test-end)))

(define test.permutations
    (lambda ()
        (test-start "permutations")
        (test* "#1"
            '((a) (b) (c))
            (permutations '(a b c) 1)
            set-equal?)
        (test* "#2"
            '((a b) (a c) (b a) (b c) (c a) (c b))
            (permutations '(a b c) 2)
            set-equal?)
        (test* "#3"
            '((a b c) (a c b) (b a c) (b c a) (c a b) (c b a))
            (permutations '(a b c) 3)
            set-equal?)
        (test-end)))

(define test.combinations
    (lambda ()
        (test-start "combinations")
        (test* "#1"
            '((a) (b) (c))
            (combinations '(a b c) 1)
            set-equal?)
        (test* "#2"
            '((a b) (a c) (b c))
            (combinations '(a b c) 2)
            set-equal?)
        (test* "#3"
            '((a b c))
            (combinations '(a b c) 3)
            set-equal?)
        (test-end)))

