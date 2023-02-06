(use gauche.test)
(load "parameterized-testing")
(load "flatten")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.atom?)
        (test.flatten?)
        (test.flatten)))

(define test.atom?
    (lambda ()
        (test-start "atom?")
        (parameterized.test*
            (list
                ; (expected x)
                (list #t 0)
                (list #t 1.5)
                (list #t 2/3)
                (list #t 'x)
                (list #t "hello")
                (list #t car)
                (list #f '())
                (list #f '(1 . 2))
                (list #f '(1 2 3)))
            atom?)
        (test-end)))

(define test.flatten?
    (lambda ()
        (test-start "flatten?")
        (parameterized.test* '(
                ; (expected x)
                (#t ())
                (#t (1))
                (#t (1 2))
                (#f ((1)))
                (#f ((1) (2))))
            flatten?)
        (test-end)))

(define test.flatten
    (lambda ()
        (test-start "flatten")
        (parameterized.test* '(
                ; (expected x)
                (() ())
                ((a) (a))
                ((a) ((a)))
                ((a) (((a))))
                ((a b c d e) ((a) b ((c d) e))))
            flatten)
        (test-end)))

