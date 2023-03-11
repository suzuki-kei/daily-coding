(use gauche.test)
(load "fibonacci-number")

(define FIBONACCI-NUMBERS
    '(0 1 1 2 3 5 8 13 21 34 55))

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.fibonacci)))

(define test.fibonacci
    (lambda ()
        (test-start "fibonacci")
        (for-each
            (lambda
                (index expected)
                (test*
                    (format "#~d" (+ index 1))
                    expected
                    (fibonacci index)))
            (iota (length FIBONACCI-NUMBERS))
            FIBONACCI-NUMBERS)
        (test-end)))

