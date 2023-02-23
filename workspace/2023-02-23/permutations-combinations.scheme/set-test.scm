(use gauche.test)
(load "set")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.include?)
        (test.set?)
        (test.subset?)
        (test.set-equal?)
        (test.xs->set)))

(define test.include?
    (lambda ()
        (test-start "include?")
        (test* "#1" #f (include? 0 '()))
        (test* "#2" #f (include? 0 '(1 2 3)))
        (test* "#3" #t (include? 1 '(1 2 3)))
        (test* "#4" #t (include? 2 '(1 2 3)))
        (test* "#5" #t (include? 3 '(1 2 3)))
        (test* "#6" #f (include? 4 '(1 2 3)))
        (test-end)))

(define test.set?
    (lambda ()
        (test-start "set?")
        (test* "#1" #t (set? '()))
        (test* "#2" #t (set? '(1)))
        (test* "#3" #f (set? '(1 1)))
        (test* "#4" #t (set? '(1 2 3)))
        (test* "#5" #f (set? '(1 2 3 2 1)))
        (test-end)))

(define test.subset?
    (lambda ()
        (test-start "subset?")
        (test* "#1" #t (subset? '() '()))
        (test* "#2" #f (subset? '(1) '()))
        (test* "#3" #t (subset? '() '(1)))
        (test* "#4" #t (subset? '(1) '(1)))
        (test* "#5" #t (subset? '(1 2 3) '(1 2 3)))
        (test* "#6" #f (subset? '(1 2 3) '(2 3 4)))
        (test* "#7" #f (subset? '(1 2 3) '(3 4 5)))
        (test* "#8" #f (subset? '(1 2 3) '(4 5 6)))
        (test-end)))

(define test.set-equal?
    (lambda ()
        (test-start "set-equal?")
        (test* "#1" #t (set-equal? '() '()))
        (test* "#2" #f (set-equal? '(1) '()))
        (test* "#3" #f (set-equal? '() '(1)))
        (test* "#4" #t (set-equal? '(1) '(1)))
        (test* "#5" #t (set-equal? '(1 2 3) '(3 2 1)))
        (test-end)))

(define test.xs->set
    (lambda ()
        (test-start "xs->set")
        (test* "#1" '() (xs->set '()) set-equal?)
        (test* "#2" '(1) (xs->set '(1)) set-equal?)
        (test* "#3" '(1) (xs->set '(1 1)) set-equal?)
        (test* "#4" '(1 2 3) (xs->set '(1 2 3)) set-equal?)
        (test* "#5" '(1 2 3) (xs->set '(1 2 3 2 1)) set-equal?)
        (test-end)))

