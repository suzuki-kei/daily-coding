(use gauche.test)
(load "statistics")

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.count)
        (test.sum)
        (test.average)
        (test.minimum)
        (test.maximum)
        (test.square)
        (test.variance)
        (test.stddev)))

(define test.count
    (lambda ()
        (test-start "count")
        (test* "#1" 0 (count '()))
        (test* "#2" 1 (count '(1)))
        (test* "#3" 2 (count '(1 2)))
        (test* "#4" 3 (count '(1 2 3)))
        (test-end)))

(define test.sum
    (lambda ()
        (test-start "sum")
        (test* "#1" 0 (sum '()))
        (test* "#2" 1 (sum '(1)))
        (test* "#3" 3 (sum '(1 2)))
        (test* "#4" 6 (sum '(1 2 3)))
        (test* "#5" -3 (sum '(-1 2 -3 4 -5)))
        (test-end)))

(define test.average
    (lambda ()
        (test-start "average")
        (test* "#1" (test-error) (average '()))
        (test* "#2" 0.0 (average '(0)) approx=?)
        (test* "#3" 0.5 (average '(0 1)) approx=?)
        (test* "#4" 1.0 (average '(0 1 2)) approx=?)
        (test* "#5" 1.5 (average '(0 1 2 3)) approx=?)
        (test* "#6" 2.0 (average '(0 1 2 3 4)) approx=?)
        (test-end)))

(define test.minimum
    (lambda ()
        (test-start "minimum")
        (test* "#1" (test-error) (minimum '()))
        (test* "#2" 0 (minimum '(0)))
        (test* "#3" 1 (minimum '(1 2)))
        (test* "#4" 2 (minimum '(4 2 3)))
        (test-end)))

(define test.maximum
    (lambda ()
        (test-start "maximum")
        (test* "#1" (test-error) (maximum '()))
        (test* "#2" 0 (maximum '(0)))
        (test* "#3" 2 (maximum '(1 2)))
        (test* "#4" 4 (maximum '(4 2 3)))
        (test-end)))

(define test.square
    (lambda ()
        (test-start "square")
        (test* "#1" 0 (square 0))
        (test* "#2" 1 (square 1))
        (test* "#3" 4 (square 2))
        (test* "#4" 9 (square 3))
        (test-end)))

(define test.variance
    (lambda ()
        (test-start "variance")
        (test* "#1" (test-error) (variance '()))
        (test* "#2" 0 (variance '(1)) approx=?)
        (test* "#3" 1/4 (variance '(1 2)) approx=?)
        (test* "#4" 2/3 (variance '(1 2 3)) approx=?)
        (test-end)))

(define test.stddev
    (lambda ()
        (test-start "stddev")
        (test* "#1" (test-error) (stddev '()))
        (test* "#2" (sqrt 0) (stddev '(1)) approx=?)
        (test* "#3" (sqrt 1/4) (stddev '(1 2)) approx=?)
        (test* "#4" (sqrt 2/3) (stddev '(1 2 3)) approx=?)
        (test-end)))

