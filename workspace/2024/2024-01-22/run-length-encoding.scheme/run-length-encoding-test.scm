(load "run-length-encoding")
(use gauche.test)

(define TEST-DATA-TUPLES '(
    ; (xs encoded-runs)
    (()            ())
    ((a)           ((a . 1)))
    ((a a)         ((a . 2)))
    ((a a a)       ((a . 3)))
    ((a b)         ((a . 1) (b . 1)))
    ((a a b)       ((a . 2) (b . 1)))
    ((a b b)       ((a . 1) (b . 2)))
    ((a a b c c c) ((a . 2) (b . 1) (c . 3)))))

(define parameterized
    (lambda (callback tuples)
        (for-each
            (lambda (arguments)
                (apply callback arguments))
            (map
                cons
                (iota (length tuples))
                tuples))))

(define main
    (lambda (_)
        (test-all)))

(define test-all
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
            (lambda (i xs encoded-runs)
                (test*
                    (format "#~d" (+ i 1))
                    xs
                    (decode (encode xs))))
            TEST-DATA-TUPLES)))

(define test.encode
    (lambda ()
        (test-section "encode")
        (parameterized
            (lambda (i xs encoded-runs)
                (test*
                    (format "#~d" (+ i 1))
                    encoded-runs
                    (encode xs)))
            TEST-DATA-TUPLES)))

(define test.decode
    (lambda ()
        (test-section "decode")
        (parameterized
            (lambda (i xs encoded-runs)
                (test*
                    (format "#~d" (+ i 1))
                    xs
                    (decode encoded-runs)))
            TEST-DATA-TUPLES)))

