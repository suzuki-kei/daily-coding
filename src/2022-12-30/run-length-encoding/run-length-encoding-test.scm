
(use gauche.test)
(load "parameterized-testing.scm")
(load "run-length-encoding.scm")

(define TEST-DATA-TUPLES '(
    ; (xs runs encoded-runs)
    (()             ()                  ())
    ((a)            ((a))               ((a . 1)))
    ((a a)          ((a a))             ((a . 2)))
    ((a a a)        ((a a a))           ((a . 3)))
    ((a b)          ((a) (b))           ((a . 1) (b . 1)))
    ((a b b)        ((a) (b b))         ((a . 1) (b . 2)))
    ((a a b c c c)  ((a a) (b) (c c c)) ((a . 2) (b . 1) (c . 3)))))

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.encode/decode)
        (test.encode)
        (test.decode)))

(define test.encode/decode
    (lambda ()
        (test-start "encode/decode")
        (test.parameterized TEST-DATA-TUPLES
            (lambda (index xs runs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    xs
                    (decode (encode xs)))))
        (test-end)))

(define test.encode
    (lambda ()
        (test-start "encode")
        (test.parameterized TEST-DATA-TUPLES
            (lambda (index xs runs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    encoded-runs
                    (encode xs))))
        (test-end)))

(define test.decode
    (lambda ()
        (test-start "decode")
        (test.parameterized TEST-DATA-TUPLES
            (lambda (index xs runs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    xs
                    (decode encoded-runs))))
        (test-end)))

