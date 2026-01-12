(use gauche.test)
(load "parameterized-testing")
(load "run-length-encoding")

(define TEST-DATA-TUPLES '(
    ; (xs encoded-runs)
    (()             ())
    ((a)            ((a . 1)))
    ((a a)          ((a . 2)))
    ((a a a)        ((a . 3)))
    ((a b)          ((a . 1) (b . 1)))
    ((a b b)        ((a . 1) (b . 2)))
    ((a a b c c c)  ((a . 2) (b . 1) (c . 3)))))

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.encode/decode)
        (test.encode)
        (test.decode)))

(define test.encode/decode
    (lambda ()
        (test-start "encode/decode")
        (parameterized-test
            (lambda (index xs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    xs
                    (decode (encode xs))))
            TEST-DATA-TUPLES)
        (test-end)))

(define test.encode
    (lambda ()
        (test-start "encode")
        (parameterized-test
            (lambda (index xs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    encoded-runs
                    (encode xs)))
            TEST-DATA-TUPLES)
        (test-end)))

(define test.decode
    (lambda ()
        (test-start "decode")
        (parameterized-test
            (lambda (index xs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    xs
                    (decode encoded-runs)))
            TEST-DATA-TUPLES)
        (test-end)))

