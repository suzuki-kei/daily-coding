(use gauche.test)
(load "parameterized-testing")
(load "set")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
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
        (define test-data-tuples '(
            ; (expected x xs)
            (#f 0 ())
            (#f 0 (1))
            (#t 1 (1))
            (#f 2 (1))
            (#f 0 (1 2 3))
            (#t 1 (1 2 3))
            (#t 2 (1 2 3))
            (#t 3 (1 2 3))
            (#f 4 (1 2 3))))
        (test-start "include?")
        (parameterized.test* test-data-tuples include?)
        (test-end)))

(define test.set?
    (lambda ()
        (define test-data-tuples '(
            ; (expected xs)
            (#t ())
            (#t (1))
            (#f (1 1))
            (#t (1 2))
            (#t (2 1))
            (#t (1 2 3))))
        (test-start "set?")
        (parameterized.test* test-data-tuples set?)
        (test-end)))

(define test.set-equal?
    (lambda ()
        (define test-data-tuples '(
            ; (expected set1 set2)
            (#t () ())
            (#f (1) ())
            (#f () (1))
            (#t (1) (1))
            (#f (1 2) ())
            (#f (1 2) (1))
            (#t (1 2) (2 1))))
        (test-start "set-equal?")
        (parameterized.test* test-data-tuples set-equal?)
        (test-end)))

(define test.xs->set
    (lambda ()
        (define test-data-tuples '(
            ; (expected xs)
            (() ())
            ((1) (1))
            ((1) (1 1))))
        (test-start "xs->set")
        (parameterized.test* test-data-tuples xs->set set-equal?)
        (test-end)))

(define test.set-union
    (lambda ()
        (define test-data-tuples '(
            ; (expected set1 set2)
            (() () ())
            ((1) (1) ())
            ((1) () (1))
            ((1) (1) (1))
            ((1 2 3 4 5) (1 2 3) (3 4 5))))
        (test-start "set-union")
        (parameterized.test* test-data-tuples set-union set-equal?)
        (test-end)))

(define test.set-difference
    (lambda ()
        (define test-data-tuples '(
            ; (expected set1 set2)
            (() () ())
            (() () (1))
            ((1) (1) ())
            ((1 2) (1 2 3 4 5) (3 4 5 6 7))))
        (test-start "set-difference")
        (parameterized.test* test-data-tuples set-difference set-equal?)
        (test-end)))

(define test.set-intersection
    (lambda ()
        (define test-data-tuples '(
            ; (expected set1 set2)
            (() () ())
            (() (1) (2))
            ((1) (1) (1 2))
            ((3 4 5) (1 2 3 4 5) (3 4 5 6 7))))
        (test-start "set-intersection")
        (parameterized.test* test-data-tuples set-intersection set-equal?)
        (test-end)))

