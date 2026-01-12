(use gauche.test)
(load "srfi-1")

(define main
    (lambda (_)
        (test-start "srfi-1")
        (test-take)
        (test-drop)
        (test-take-right)
        (test-drop-right)
        (test-split-at)
        (test-end)))

(define test-take
    (lambda ()
        (test-section "take")
        (test* "#1" '() (take '(a b c) 0))
        (test* "#2" '(a) (take '(a b c) 1))
        (test* "#3" '(a b) (take '(a b c) 2))
        (test* "#4" '(a b c) (take '(a b c) 3))
        (test* "#5" (test-error) (take '(a b c) 4))))

(define test-drop
    (lambda ()
        (test-section "drop")
        (test* "#1" '(a b c) (drop '(a b c) 0))
        (test* "#2" '(b c) (drop '(a b c) 1))
        (test* "#3" '(c) (drop '(a b c) 2))
        (test* "#4" '() (drop '(a b c) 3))
        (test* "#5" (test-error) (drop '(a b c) 4))))

(define test-take-right
    (lambda ()
        (test-section "take-right")
        (test* "#1" '() (take-right '(a b c) 0))
        (test* "#2" '(c) (take-right '(a b c) 1))
        (test* "#3" '(b c) (take-right '(a b c) 2))
        (test* "#4" '(a b c) (take-right '(a b c) 3))
        (test* "#5" (test-error) (take-right '(a b c) 4))))

(define test-drop-right
    (lambda ()
        (test-section "drop-right")
        (test* "#1" '(a b c) (drop-right '(a b c) 0))
        (test* "#2" '(a b) (drop-right '(a b c) 1))
        (test* "#3" '(a) (drop-right '(a b c) 2))
        (test* "#4" '() (drop-right '(a b c) 3))
        (test* "#5" (test-error) (drop-right '(a b c) 4))))

(define test-split-at
    (lambda ()
        (define receive-split-at
            (lambda (xs n)
                (receive
                    (left right)
                    (split-at xs n)
                    (list left right))))
        (test-section "split-at")
        (test* "#1" '(() ()) (receive-split-at '() 0))
        (test* "#2" (test-error) (receive-split-at '() 1))
        (test* "#3" '(() (a b c)) (receive-split-at '(a b c) 0))
        (test* "#4" '((a) (b c)) (receive-split-at '(a b c) 1))
        (test* "#5" '((a b) (c)) (receive-split-at '(a b c) 2))
        (test* "#6" '((a b c) ()) (receive-split-at '(a b c) 3))
        (test* "#7" (test-error) (receive-split-at '(a b c) 4))))

