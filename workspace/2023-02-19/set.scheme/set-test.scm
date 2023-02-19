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
        (test.subset?)
        (test.set-equal?)
        (test.xs->set)
        (test.set-union)
        (test.set-difference)
        (test.set-intersection)))

(define test.include?
    (lambda ()
        (test-start "include?")
        (parameterized-test '(
                ; (expected x xs)
                (#f 0 ())
                (#f 0 (1 2 3))
                (#t 1 (1 2 3))
                (#t 2 (1 2 3))
                (#t 3 (1 2 3))
                (#f 4 (1 2 3)))
            include?)
        (test-end)))

(define test.set?
    (lambda ()
        (test-start "set?")
        (parameterized-test '(
                ; (expected xs)
                (#t ())
                (#t (1))
                (#t (1 2))
                (#t (1 2 3))
                (#f (1 1))
                (#f (1 2 1)))
            set?)
        (test-end)))

(define test.subset?
    (lambda ()
        (test-start "subset?")
        (parameterized-test '(
                ; (expected set1 set2)
                (#t () ())
                (#t () (1))
                (#t () (1 2))
                (#t () (1 2 3))
                (#f (0) (1 2 3))
                (#t (1) (1 2 3))
                (#t (2) (1 2 3))
                (#t (3) (1 2 3))
                (#f (4) (1 2 3))
                (#f (1 2 3) ())
                (#f (1 2 3) (1))
                (#f (1 2 3) (1 2))
                (#f (1 2 3) (1 2 4)))
            subset?)
        (test-end)))

(define test.set-equal?
    (lambda ()
        (test-start "set-equal?")
        (parameterized-test `(
                ; (expected xs)
                (,(test-error) (1 1) ())
                (,(test-error) () (1 1))
                (#t () ())
                (#t (1) (1))
                (#t (1 2 3) (3 2 1))
                (#f (1 2 3) (2 3 4))
                (#f (1 2 3) (3 4 5))
                (#f (1 2 3) (4 5 6)))
            set-equal?)
        (test-end)))

(define test.xs->set
    (lambda ()
        (test-start "xs->set")
        (parameterized-test '(
                ; (expected xs)
                (() ())
                ((1) (1))
                ((1) (1 1))
                ((1 2) (1 2))
                ((1 2 3) (1 2 3)))
            xs->set
            set-equal?)
        (test-end)))

(define test.set-union
    (lambda ()
        (test-start "set-union")
        (parameterized-test '(
                ; (expected xs)
                (() () ())
                ((1) (1) ())
                ((1) () (1))
                ((1) (1) (1))
                ((1 2 3 4 5) (1 2 3) (3 4 5)))
            set-union
            set-equal?)
        (test-end)))

(define test.set-difference
    (lambda ()
        (test-start "set-difference")
        (parameterized-test '(
                ; (expected xs)
                (() () ())
                ((1) (1) ())
                (() () (1))
                (() (1) (1))
                ((1 2) (1 2 3) (3 4 5)))
            set-difference
            set-equal?)
        (test-end)))

(define test.set-intersection
    (lambda ()
        (test-start "set-intersection")
        (parameterized-test '(
                ; (expected xs)
                (() () ())
                (() (1) ())
                (() () (1))
                ((1) (1) (1))
                ((3) (1 2 3) (3 4 5)))
            set-intersection
            set-equal?)
        (test-end)))

