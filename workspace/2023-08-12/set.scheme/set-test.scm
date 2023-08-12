(load "set")
(load "parameterized-testing")

(define main
    (lambda (_)
        (test-all)))

(define test-all
    (lambda ()
        (test-start "set")
        (test.include?)
        (test.set?)
        (test.subset?)
        (test.set-equal?)
        (test.make-set)
        (test.set-union)
        (test.set-difference)
        (test.set-intersection)
        (test-end)))

(define-parameterized-test test.include? "include?" '(
    (#f (include? 0 '()))
    (#f (include? 0 '(1)))
    (#t (include? 1 '(1)))
    (#f (include? 2 '(1)))
    (#f (include? 0 '(1 2 3)))
    (#t (include? 1 '(1 2 3)))
    (#t (include? 2 '(1 2 3)))
    (#t (include? 3 '(1 2 3)))
    (#f (include? 4 '(1 2 3)))))

(define-parameterized-test test.set? "set?" '(
    (#t (set? '()))
    (#t (set? '(1)))
    (#f (set? '(1 1)))
    (#t (set? '(1 2)))
    (#t (set? '(2 1)))
    (#f (set? '(1 1 1)))
    (#f (set? '(1 2 2)))
    (#f (set? '(2 2 1)))
    (#f (set? '(2 1 2)))))

(define-parameterized-test test.subset? "subset?" '(
    (#t (subset? '() '()))
    (#t (subset? '(1) '(1)))
    (#f (subset? '(1) '(2)))
    (#f (subset? '(2) '(1)))
    (#f (subset? '(1 2) '(0 1)))
    (#t (subset? '(1 2) '(1 2)))
    (#f (subset? '(1 2) '(2 3)))))

(define-parameterized-test test.set-equal? "set-equal?" '(
    (#t (set-equal? '() '()))
    (#f (set-equal? '(1) '()))
    (#f (set-equal? '() '(1)))
    (#t (set-equal? '(1) '(1)))
    (#f (set-equal? '(1) '(2)))
    (#f (set-equal? '(2) '(1)))
    (#t (set-equal? '(1 2 3) '(3 2 1)))))

(define-parameterized-test test.make-set "make-set" '(
    (() (make-set '()))
    ((1) (make-set '(1)))
    ((1) (make-set '(1 1)))
    ((1 2 3) (make-set '(1 2 3)))
    ((1 2 3) (make-set '(1 2 3 2 1))))
    set-equal?)

(define-parameterized-test test.set-union "set-union" '(
    (() (set-union '() '()))
    ((1) (set-union '(1) '()))
    ((1) (set-union '() '(1)))
    ((1) (set-union '(1) '(1)))
    ((1 2 3 4) (set-union '(1 2 3) '(2 3 4))))
    set-equal?)

(define-parameterized-test test.set-difference "set-difference" '(
    (() (set-difference '() '()))
    ((1) (set-difference '(1) '()))
    (() (set-difference '() '(1)))
    (() (set-difference '(1) '(1)))
    ((2) (set-difference '(1 2) '(1)))
    ((1) (set-difference '(1 2) '(2)))
    ((1 3 5) (set-difference '(1 2 3 4 5) '(2 4))))
    set-equal?)

(define-parameterized-test test.set-intersection "set-intersection " '(
    (() (set-intersection '() '()))
    ((1) (set-intersection '(1) '(1)))
    (() (set-intersection '(1) '(2)))
    (() (set-intersection '(2) '(1)))
    ((2 4) (set-intersection '(1 2 3 4 5) '(2 4))))
    set-equal?)

