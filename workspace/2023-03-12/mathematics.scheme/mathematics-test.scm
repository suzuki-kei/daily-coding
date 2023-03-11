(use gauche.test)
(load "parameterized-testing")
(load "mathematics")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.count)
        (test.minimum)
        (test.maximum)
        (test.sum)
        (test.product)
        (test.average)
        (test.variance)
        (test.stddev)))

(define test.count
    (lambda ()
        (test-start "count")
        (parameterized-test count `(
            ; (expected xs)
            (0 ())
            (1 (1))
            (2 (1 2))
            (3 (1 2 3))
            (4 (1 2 3 4))
            (5 (1 2 3 4 5))))
        (test-end)))

(define test.minimum
    (lambda ()
        (test-start "minimum")
        (parameterized-test minimum `(
            ; (expected xs)
            (,(test-error) ())
            (1 (1))
            (1 (1 2))
            (1 (1 2 3))
            (1 (1 2 3 4))
            (1 (1 2 3 4 5))))
        (test-end)))

(define test.maximum
    (lambda ()
        (test-start "maximum")
        (parameterized-test maximum `(
            ; (expected xs)
            (,(test-error) ())
            (1 (1))
            (2 (1 2))
            (3 (1 2 3))
            (4 (1 2 3 4))
            (5 (1 2 3 4 5))))
        (test-end)))

(define test.sum
    (lambda ()
        (test-start "sum")
        (parameterized-test sum `(
            ; (expected xs)
            (0 ())
            (1 (1))
            (3 (1 2))
            (6 (1 2 3))
            (10 (1 2 3 4))
            (15 (1 2 3 4 5))))
        (test-end)))

(define test.product
    (lambda ()
        (test-start "product")
        (parameterized-test product `(
            ; (expected xs)
            (1 ())
            (1 (1))
            (2 (1 2))
            (6 (1 2 3))
            (24 (1 2 3 4))
            (120 (1 2 3 4 5))))
        (test-end)))

(define test.average
    (lambda ()
        (test-start "average")
        (parameterized-test average `(
            ; (expected xs)
            (,(test-error) ())
            (1/1 (1))
            (3/2 (1 2))
            (6/3 (1 2 3))
            (10/4 (1 2 3 4))
            (15/5 (1 2 3 4 5))))
        (test-end)))

(define test.variance
    (lambda ()
        (test-start "variance")
        (parameterized-test variance `(
            ; (expected xs)
            (,(test-error) ())
            (0 (1))
            (1/4 (1 2))
            (2/3 (1 2 3))
            (5/4 (1 2 3 4))
            (2 (1 2 3 4 5))))
        (test-end)))

(define test.stddev
    (lambda ()
        (test-start "stddev")
        (parameterized-test stddev `(
            ; (expected xs)
            (,(test-error) ())
            (,(sqrt 0) (1))
            (,(sqrt 1/4) (1 2))
            (,(sqrt 2/3) (1 2 3))
            (,(sqrt 5/4) (1 2 3 4))
            (,(sqrt 2) (1 2 3 4 5))))
        (test-end)))

