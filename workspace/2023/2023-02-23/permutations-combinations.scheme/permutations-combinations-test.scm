(use gauche.test)
(load "set")
(load "permutations-combinations")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.atom?)
        (test.flatten?)
        (test.tree->list)
        (test.remove-nth)
        (test.permutations)
        (test.combinations)))

(define test.atom?
    (lambda ()
        (test-start "atom?")
        (test* "#1" #t (atom? 0))
        (test* "#2" #t (atom? 1.2))
        (test* "#3" #t (atom? 1/2))
        (test* "#4" #f (atom? '()))
        (test* "#5" #f (atom? '(a b c)))
        (test-end)))

(define test.flatten?
    (lambda ()
        (test-start "flatten?")
        (test* "#1" #t (flatten? '()))
        (test* "#2" #t (flatten? '(1)))
        (test* "#3" #t (flatten? '(1 2)))
        (test* "#4" #t (flatten? '(1 2 3)))
        (test* "#5" #f (flatten? '((1))))
        (test-end)))

(define test.tree->list
    (lambda ()
        (test-start "tree->list")
        (test* "#1" '() (tree->list '() atom?))
        (test* "#2" '(1 2 3) (tree->list '(1 (2 (3))) atom?))
        (test* "#3" '((a b) (c d) (e f)) (tree->list '((a b) ((c d) (e f))) flatten?))
        (test-end)))

(define test.remove-nth
    (lambda ()
        (define remove-nth/receive
            (lambda (xs nth)
                (receive
                    (ys y)
                    (remove-nth xs nth)
                    (list ys y))))
        (test-start "remove-nth")
        (test* "#1" '((  b c d e) a) (remove-nth/receive '(a b c d e) 0))
        (test* "#2" '((a   c d e) b) (remove-nth/receive '(a b c d e) 1))
        (test* "#3" '((a b   d e) c) (remove-nth/receive '(a b c d e) 2))
        (test* "#4" '((a b c   e) d) (remove-nth/receive '(a b c d e) 3))
        (test* "#5" '((a b c d  ) e) (remove-nth/receive '(a b c d e) 4))
        (test-end)))

(define test.permutations
    (lambda ()
        (test-start "permutations")
        (test* "#1"
            '((a) (b) (c))
            (permutations '(a b c) 1)
            set-equal?)
        (test* "#2"
            '((a b) (a c)
              (b a) (b c)
              (c a) (c b))
            (permutations '(a b c) 2)
            set-equal?)
        (test* "#3"
            '((a b c) (a c b)
              (b a c) (b c a)
              (c a b) (c b a))
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

