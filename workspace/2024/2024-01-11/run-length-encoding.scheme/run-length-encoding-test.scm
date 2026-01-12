(load "parameterized")
(load "run-length-encoding")
(use gauche.test)

(define TEST-DATA-TUPLES '(
    ; (xs encoded-runs)
    (()            ())
    ((a)           ((a . 1)))
    ((a a)         ((a . 2)))
    ((a b)         ((a . 1) (b . 1)))
    ((a a b c c c) ((a . 2) (b . 1) (c . 3)))))

(define main
    (lambda (_)
        (unit-test-all)))

(define unit-test-all
    (lambda ()
        (test-start "run-length-encoding")
        (test.encode/decode)
        (test.encode)
        (test.decode)
        (test-end)))

(define test.encode/decode
    (lambda ()
        (test-section "encode/decode")
        (parameterized
            (lambda (index xs encoded-runs)
                (test*
                    (format "#~d" index)
                    xs
                    (decode (encode xs))))
            TEST-DATA-TUPLES)))

(define test.encode
    (lambda ()
        (test-section "encode")
        (parameterized
            (lambda (index xs encoded-runs)
                (test*
                    (format "#~d" index)
                    encoded-runs
                    (encode xs)))
            TEST-DATA-TUPLES)))

(define test.decode
    (lambda ()
        (test-section "decode")
        (parameterized
            (lambda (index xs encoded-runs)
                (test*
                    (format "#~d" index)
                    xs
                    (decode encoded-runs)))
            TEST-DATA-TUPLES)))

