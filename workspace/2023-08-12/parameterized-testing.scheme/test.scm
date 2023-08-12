(load "parameterized-testing")

(define main
    (lambda (_)
        (test-all)))

(define test-all
    (lambda ()
        (test-start "parameterized-testing")
        (test.+)
        (test-end)))

(define-parameterized-test* test.+ "+" '(
    (3 (+ 1 2))
    (7 (+ 3 4))
    (11 (+ 5 6))
    (15 (+ 7 8))))

