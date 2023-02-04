(use gauche.test)
(load "statistics")

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.count)
        (test.less)
        (test.greater)
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
        (test* "#1" 0 (count '()))
        (test* "#2" 1 (count '(1)))
        (test* "#3" 2 (count '(1 2)))
        (test* "#4" 3 (count '(1 2 3)))
        (test-end)))

(define test.less
    (lambda ()
        (test-start "less")
        (test* "#1" 0 (less 0 1))
        (test* "#2" 0 (less 1 0))
        (test-end)))

(define test.greater
    (lambda ()
        (test-start "greater")
        (test* "#1" 1 (greater 0 1))
        (test* "#2" 1 (greater 1 0))
        (test-end)))

(define test.minimum
    (lambda ()
        (test-start "minimum")
        (test* "#1" (test-error) (minimum '()))
        (test* "#2" 1 (minimum '(1)))
        (test* "#3" 1 (minimum '(1 2)))
        (test* "#4" 1 (minimum '(2 1)))
        (test* "#5" 1 (minimum '(1 2 3)))
        (test* "#6" 1 (minimum '(3 2 1)))
        (test-end)))

(define test.maximum
    (lambda ()
        (test-start "maximum")
        (test* "#1" (test-error) (maximum '()))
        (test* "#2" 1 (maximum '(1)))
        (test* "#3" 2 (maximum '(1 2)))
        (test* "#4" 2 (maximum '(2 1)))
        (test* "#5" 3 (maximum '(1 2 3)))
        (test* "#6" 3 (maximum '(3 2 1)))
        (test-end)))

(define test.sum
    (lambda ()
        (test-start "sum")
        (test* "#1" 0 (sum '()))
        (test* "#2" 0 (sum '(0)))
        (test* "#3" 1 (sum '(0 1)))
        (test* "#4" 3 (sum '(0 1 2)))
        (test* "#5" 6 (sum '(0 1 2 3)))
        (test-end)))

(define test.product
    (lambda ()
        (test-start "product")
        (test* "#1" 1 (product '()))
        (test* "#2" 1 (product '(1)))
        (test* "#3" 2 (product '(1 2)))
        (test* "#4" 6 (product '(1 2 3)))
        (test-end)))

(define test.average
    (lambda ()
        (test-start "average")
        (test* "#1" (test-error) (average '()))
        (test* "#2" 1/1 (average '(1)))
        (test* "#3" 3/2 (average '(1 2)))
        (test* "#4" 6/3 (average '(1 2 3)))
        (test-end)))

(define test.variance
    (lambda ()
        (test-start "variance")
        (test* "#1" (test-error) (variance '()))
        (test* "#2" 0 (variance '(1)))
        (test* "#2" 0 (variance '(1 1)))
        (test* "#3" 1/4 (variance '(1 2)))
        (test* "#4" 2/3 (variance '(1 2 3)))
        (test-end)))

(define test.stddev
    (lambda ()
        (test-start "stddev")
        (test* "#1" (test-error) (stddev '()))
        (test* "#2" (sqrt 0) (stddev '(1)) approx=?)
        (test* "#3" (sqrt 0) (stddev '(1 1)) approx=?)
        (test* "#4" (sqrt 1/4) (stddev '(1 2)) approx=?)
        (test* "#5" (sqrt 2/3) (stddev '(1 2 3)) approx=?)
        (test-end)))

