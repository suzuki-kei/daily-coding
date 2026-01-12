(load "run-length-encoding")
(use gauche.test)

(define TEST-DATA-TUPLES '(
    ; (xs encoded-runs)
    (()            ())
    ((a)           ((a . 1)))
    ((a a)         ((a . 2)))
    ((a a a)       ((a . 3)))
    ((a b)         ((a . 1) (b . 1)))
    ((a a b c c c) ((a . 2) (b . 1) (c . 3)))))

(define indexed
    (lambda (xs :optional (start 0))
        (map
            cons
            (iota (length xs) start)
            xs)))

(define for-each-apply
    (lambda (callback tuples)
        (for-each
            (lambda (tuple)
                (apply callback tuple))
            tuples)))

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
        (for-each-apply
            (lambda (i xs encoded-runs)
                (test*
                    (format "#~d" i)
                    xs
                    (decode (encode xs))))
            (indexed TEST-DATA-TUPLES 1))))

(define test.encode
    (lambda ()
        (test-section "encode")
        (for-each-apply
            (lambda (i xs encoded-runs)
                (test*
                    (format "#~d" i)
                    encoded-runs
                    (encode xs)))
            (indexed TEST-DATA-TUPLES 1))))

(define test.decode
    (lambda ()
        (test-section "decode")
        (for-each-apply
            (lambda (i xs encoded-runs)
                (test*
                    (format "#~d" i)
                    xs
                    (decode encoded-runs)))
            (indexed TEST-DATA-TUPLES 1))))

