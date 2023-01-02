
(use srfi-64)
(load "my-library.scm")

(define main
    (lambda (arguments)
        (test)
        0))

(define test
    (lambda ()
        (test-runner-current (test-runner-simple))
        (test.increment)
        (test.decrement)))

(define test.increment
    (lambda ()
        (test-begin "increment")
        (test-equal 1 (increment 0))
        (test-equal 2 (increment 1))
        (test-equal 3 (increment 2))
        (test-end)))

(define test.decrement
    (lambda ()
        (test-begin "decrement")
        (test-equal 0 (decrement 1))
        (test-equal 1 (decrement 2))
        (test-equal 2 (decrement 3))
        (test-end)))

