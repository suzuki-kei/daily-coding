(use gauche.test)
(load "parameterized-testing")

(define main
    (lambda (_)
        (test-start "test")
        (test-increment)
        (test-decrement)
        (test-end)))

(define increment
    (lambda (x)
        (+ x 1)))

(define decrement
    (lambda (x)
        (- x 1)))

(define-parameterized-test increment '(
    (1 (0))
    (2 (1))
    (3 (2))
    (4 (3))
    (5 (4))))

(define-parameterized-test decrement '(
    (0 (1))
    (1 (2))
    (2 (3))
    (3 (4))
    (4 (5))))

