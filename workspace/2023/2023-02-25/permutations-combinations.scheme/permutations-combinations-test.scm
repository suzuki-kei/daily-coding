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
        (test* "#3" #t (atom? 'a))
        (test* "#4" #t (atom? "a"))
        (test* "#5" #f (atom? '()))
        (test* "#6" #f (atom? '(a)))
        (test-end)))

(define test.flatten?
    (lambda ()
        (test-start "flatten?")
        (test* "#1" #t (flatten? '()))
        (test* "#2" #t (flatten? '(a)))
        (test* "#3" #t (flatten? '(a b)))
        (test* "#4" #f (flatten? '((a))))
        (test* "#5" #f (flatten? '((a) b)))
        (test* "#6" #f (flatten? '(a (b))))
        (test-end)))

(define test.tree->list
    (lambda ()
        (test-start "tree->list")
        (test* "#1" '() (tree->list '() flatten?))
        (test* "#2" '((a)) (tree->list '((a)) flatten?))
        (test* "#3" '((a b)) (tree->list '((a b)) flatten?))
        (test* "#4" '((a) (b)) (tree->list '((a) (b)) flatten?))
        (test* "#5" '((a) (b) (c)) (tree->list '(((a)) ((b)) ((c))) flatten?))
        (test-end)))

(define test.remove-nth
    (lambda ()
        (define remove-nth/values
            (lambda (xs nth)
                (call-with-values
                    (lambda ()
                        (remove-nth xs nth))
                    list)))
        (test-start "remove-nth")
        (test* "#1" (test-error) (remove-nth/values '() 0))
        (test* "#2" '((  b c d e) a) (remove-nth/values '(a b c d e) 0))
        (test* "#3" '((a   c d e) b) (remove-nth/values '(a b c d e) 1))
        (test* "#4" '((a b   d e) c) (remove-nth/values '(a b c d e) 2))
        (test* "#5" '((a b c   e) d) (remove-nth/values '(a b c d e) 3))
        (test* "#6" '((a b c d  ) e) (remove-nth/values '(a b c d e) 4))
        (test* "#7" (test-error)     (remove-nth/values '(a b c d e) 5))
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

