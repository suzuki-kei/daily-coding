(use gauche.test)
(load "parameterized-testing")
(load "set")

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.include?)
        (test.set?)
        (test.set-equal?)
        (test.xs->set)
        (test.set-union)
        (test.set-difference)
        (test.set-intersection)))

(define test.include?
    (lambda ()
        (test-start "include?")
        (test* "#1" #f (include? 0 '()))
        (test* "#2" #f (include? 0 '(1)))
        (test* "#3" #t (include? 1 '(1)))
        (test* "#4" #f (include? 2 '(1)))
        (test* "#5" #f (include? 0 '(1 2 3)))
        (test* "#6" #t (include? 1 '(1 2 3)))
        (test* "#7" #t (include? 2 '(1 2 3)))
        (test* "#8" #t (include? 3 '(1 2 3)))
        (test* "#9" #f (include? 4 '(1 2 3)))
        (test-end)))

(define test.set?
    (lambda ()
        (test-start "set?")
        (test* "#1" #t (set? '()))
        (test* "#2" #t (set? '(1)))
        (test* "#3" #f (set? '(1 1)))
        (test* "#4" #t (set? '(1 2)))
        (test* "#5" #t (set? '(2 1)))
        (test* "#6" #t (set? '(1 2 3)))
        (test-end)))

(define test.set-equal?
    (lambda ()
        (test-start "set-equal?")
        (test* "#1" #t (set-equal? '() '()))
        (test* "#2" #f (set-equal? '(1) '()))
        (test* "#3" #f (set-equal? '() '(1)))
        (test* "#4" #t (set-equal? '(1) '(1)))
        (test* "#5" #f (set-equal? '(1 2) '()))
        (test* "#6" #f (set-equal? '(1 2) '(1)))
        (test* "#7" #t (set-equal? '(1 2) '(2 1)))
        (test-end)))

(define test.xs->set
    (lambda ()
        (test-start "xs->set")
        (test* "#1" '() (xs->set '()) set-equal?)
        (test* "#2" '(1) (xs->set '(1)) set-equal?)
        (test* "#3" '(1) (xs->set '(1 1)) set-equal?)
        (test-end)))

(define test.set-union
    (lambda ()
        (test-start "set-union")
        (test* "#1" '() (set-union '() '()) set-equal?)
        (test* "#2" '(1) (set-union '(1) '()) set-equal?)
        (test* "#3" '(1) (set-union '() '(1)) set-equal?)
        (test* "#4" '(1) (set-union '(1) '(1)) set-equal?)
        (test* "#5" '(1 2 3 4 5) (set-union '(1 2 3) '(3 4 5)) set-equal?)
        (test-end)))

(define test.set-difference
    (lambda ()
        (test-start "set-difference")
        (test* "#1" '() (set-difference '() '()) set-equal?)
        (test* "#2" '() (set-difference '() '(1)) set-equal?)
        (test* "#3" '(1) (set-difference '(1) '()) set-equal?)
        (test* "#4" '(1 2) (set-difference '(1 2 3 4 5) '(3 4 5 6 7)) set-equal?)
        (test-end)))

(define test.set-intersection
    (lambda ()
        (test-start "set-intersection")
        (test* "#1" '() (set-intersection '() '()) set-equal?)
        (test* "#2" '() (set-intersection '(1) '(2)) set-equal?)
        (test* "#3" '(1) (set-intersection '(1) '(1 2)) set-equal?)
        (test* "#4" '(3 4 5) (set-intersection '(1 2 3 4 5) '(3 4 5 6 7)) set-equal?)
        (test-end)))

