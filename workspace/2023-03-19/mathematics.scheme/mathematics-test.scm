(use gauche.test)
(load "mathematics")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.count)
        (test.sum)
        (test.product)
        (test.minimum)
        (test.maximum)
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
        (test* "#5" 4 (count '(1 2 3 4)))
        (test* "#6" 5 (count '(1 2 3 4 5)))
        (test-end)))

(define test.sum
    (lambda ()
        (test-start "sum")
        (test* "#1" 0 (sum '()))
        (test* "#2" 1 (sum '(1)))
        (test* "#3" 3 (sum '(1 2)))
        (test* "#4" 6 (sum '(1 2 3)))
        (test* "#5" 10 (sum '(1 2 3 4)))
        (test* "#6" 15 (sum '(1 2 3 4 5)))
        (test-end)))

(define test.product
    (lambda ()
        (test-start "product")
        (test* "#1" 1 (product '()))
        (test* "#2" 1 (product '(1)))
        (test* "#3" 2 (product '(1 2)))
        (test* "#4" 6 (product '(1 2 3)))
        (test* "#5" 24 (product '(1 2 3 4)))
        (test* "#6" 120 (product '(1 2 3 4 5)))
        (test-end)))

(define test.minimum
    (lambda ()
        (test-start "minimum")
        (test* "#1" (test-error) (minimum '()))
        (test* "#2" 1 (minimum '(1)))
        (test* "#3" 1 (minimum '(1 2)))
        (test* "#4" 1 (minimum '(3 1 2)))
        (test* "#5" 1 (minimum '(3 1 2 4)))
        (test* "#6" 1 (minimum '(5 3 1 2 4)))
        (test-end)))

(define test.maximum
    (lambda ()
        (test-start "maximum")
        (test* "#1" (test-error) (maximum '()))
        (test* "#2" 1 (maximum '(1)))
        (test* "#3" 2 (maximum '(1 2)))
        (test* "#4" 3 (maximum '(3 1 2)))
        (test* "#5" 4 (maximum '(3 1 2 4)))
        (test* "#6" 5 (maximum '(5 3 1 2 4)))
        (test-end)))

(define test.average
    (lambda ()
        (test-start "average")
        (test* "#1" (test-error) (average '()))
        (test* "#2" 1/1 (average '(1)))
        (test* "#3" 3/2 (average '(1 2)))
        (test* "#4" 6/3 (average '(3 1 2)))
        (test* "#5" 10/4 (average '(3 1 2 4)))
        (test* "#6" 15/5 (average '(5 3 1 2 4)))
        (test-end)))

(define test.variance
    (lambda ()
        (test-start "variance")
        (test* "#1" (test-error) (variance '()))
        (test* "#2" 0/1 (variance '(1)) approx=?)
        (test* "#3" 1/4 (variance '(1 2)) approx=?)
        (test* "#4" 2/3 (variance '(3 1 2)) approx=?)
        (test* "#5" 5/4 (variance '(3 1 2 4)) approx=?)
        (test* "#6" 10/5 (variance '(5 3 1 2 4)) approx=?)
        (test-end)))

(define test.stddev
    (lambda ()
        (test-start "stddev")
        (test* "#1" (test-error) (stddev '()))
        (test* "#2" (sqrt 0/1) (stddev '(1)) approx=?)
        (test* "#3" (sqrt 1/4) (stddev '(1 2)) approx=?)
        (test* "#4" (sqrt 2/3) (stddev '(3 1 2)) approx=?)
        (test* "#5" (sqrt 5/4) (stddev '(3 1 2 4)) approx=?)
        (test* "#6" (sqrt 10/5) (stddev '(5 3 1 2 4)) approx=?)
        (test-end)))

