(use gauche.test)
(load "srfi-1")

(define main
    (lambda (_)
        (test-start "srfi-1")
        (test-xcons)
        (test-cons*)
        (test-make-list)
        (test-list-tabulate)
        (test-list-copy)
        (test-circular-list)
        (test-iota)
        (test-end)))

(define test-xcons
    (lambda ()
        (test-section "xcons")
        (test* "#1" '(a b c) (xcons '(b c) 'a))))

(define test-cons*
    (lambda ()
        (test-section "cons*")
        (test* "#1" 1 (cons* 1))
        (test* "#2" '(1 . 2) (cons* 1 2))
        (test* "#3" '(1 2 . 3) (cons* 1 2 3))
        (test* "#4" '(1 2 3 . 4) (cons* 1 2 3 4))))

(define test-make-list
    (lambda ()
        (test-section "make-list")
        (test* "#1" '() (make-list 0 'a))
        (test* "#2" '(a) (make-list 1 'a))
        (test* "#3" '(a a) (make-list 2 'a))
        (test* "#4" '(a a a) (make-list 3 'a))))

(define test-list-tabulate
    (lambda ()
        (test-section "list-tabulate")
        (test* "#1" '() (list-tabulate 0 values))
        (test* "#2" '(0) (list-tabulate 1 values))
        (test* "#3" '(0 1) (list-tabulate 2 values))
        (test* "#4" '(0 1 2) (list-tabulate 3 values))
        (test* "#5" '(0 1 4 9 16) (list-tabulate 5 (lambda (x) (* x x))))))

(define test-list-copy
    (lambda ()
        (test-section "list-copy")
        (test* "#1" '() (list-copy '()))
        (test* "#2" '(a) (list-copy '(a)))
        (test* "#3" '(a b) (list-copy '(a b)))
        (test* "#4" '(a b c) (list-copy '(a b c)))))

(define test-circular-list
    (lambda ()
        (test-section "circular-list")
        (test* "#1" (let ((xs (list 'a))) (set-cdr! xs xs) xs) (circular-list 'a))
        (test* "#2" (let ((xs (list 'a 'b))) (set-cdr! (cdr xs) xs) xs) (circular-list 'a 'b))
        (test* "#3" (let ((xs (list 'a 'b 'c))) (set-cdr! (cddr xs) xs) xs) (circular-list 'a 'b 'c))))

(define test-iota
    (lambda ()
        (test-section "iota")
        (test* "#1" '() (iota 0))
        (test* "#2" '(0) (iota 1))
        (test* "#3" '(0 1) (iota 2))
        (test* "#4" '(0 1 2) (iota 3))
        (test* "#5" '(10 11 12) (iota 3 10))
        (test* "#5" '(10 12 14) (iota 3 10 2))))

