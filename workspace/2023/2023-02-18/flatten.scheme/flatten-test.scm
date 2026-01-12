(use gauche.test)
(load "flatten")
(load "parameterized-testing")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.atom?)
        (test.flatten)))

(define test.atom?
    (lambda ()
        (test-start "atom?")
        (test.parameterized '(
                ; (expected x)
                (#t 0)
                (#t a)
                (#t "a")
                (#f ())
                (#f (a)))
            atom?)
        (test-end)))

(define test.flatten
    (lambda ()
        (test-start "flatten")
        (test.parameterized '(
                ; (expected x)
                (() ())
                ((a) (a))
                ((a) ((a)))
                ((a b c d e) (a (b) (((c d) e)))))
            flatten)
        (test-end)))

