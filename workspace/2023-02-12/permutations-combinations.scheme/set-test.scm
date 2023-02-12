(use gauche.test)
(load "set")

(define main
    (lambda (arguents)
        (test-all)))

(define test-all
    (lambda ()
        (test.include?)
        (test.set?)
        (test.subset?)
        (test.set-equal?)))

(define test.include?
    (lambda ()
        (test-start "include?")
        (test* "#1" #f (include? 1 '()))
        (test* "#2" #t (include? 1 '(1 2 3)))
        (test* "#3" #t (include? 2 '(1 2 3)))
        (test* "#4" #t (include? 3 '(1 2 3)))
        (test* "#5" #f (include? 4 '(1 2 3)))
        (test-end)))

(define test.set?
    (lambda ()
        (test-start "set?")
        (test* "#1" #t (set? '()))
        (test* "#2" #t (set? '(1)))
        (test* "#3" #t (set? '(1 2)))
        (test* "#4" #t (set? '(1 2 3)))
        (test* "#5" #f (set? '(1 1)))
        (test* "#6" #f (set? '(1 2 2)))
        (test* "#7" #f (set? '(1 2 3 1)))
        (test-end)))

(define test.subset?
    (lambda ()
        (test-start "subset?")
        (test* "#1" #t (subset? '() '()))
        (test* "#2" #t (subset? '() '(1 2 3)))
        (test* "#3" #f (subset? '(1) '()))
        (test* "#4" #t (subset? '() '(1 2 3)))
        (test* "#5" #t (subset? '(1) '(1 2 3)))
        (test* "#6" #t (subset? '(1 2) '(1 2 3)))
        (test* "#7" #t (subset? '(1 2 3) '(1 2 3)))
        (test* "#8" #f (subset? '(1 2 3 4) '(1 2 3)))
        (test* "#9" #f (subset? '(1 2 3) '(3 4 5)))
        (test* "#10" #f (subset? '(1 2 3) '(4 5 6)))
        (test-end)))

(define test.set-equal?
    (lambda ()
        (test-start "set-equal?")
        (test* "#1" #t (set-equal? '() '()))
        (test* "#2" #t (set-equal? '(1 2 3) '(1 2 3)))
        (test* "#3" #f (set-equal? '(1 2 3) '(2 3 4)))
        (test* "#4" #f (set-equal? '(1 2 3) '(3 4 5)))
        (test* "#5" #f (set-equal? '(1 2 3) '(4 5 6)))
        (test-end)))

