(use gauche.test)
(load "run-length-encoding")

(define main
    (lambda (_)
        (test-start "run-length-encoding")
        (test-encode)
        (test-decode)
        (test-end)))

(define TEST-DATA-TUPLES '(
    ; (xs encoded)
    (()            ())
    ((a)           ((a . 1)))
    ((a a)         ((a . 2)))
    ((a a a)       ((a . 3)))
    ((a b)         ((a . 1) (b . 1)))
    ((a b b)       ((a . 1) (b . 2)))
    ((a a b)       ((a . 2) (b . 1)))
    ((a a b c c c) ((a . 2) (b . 1) (c . 3)))))

(define for-each-indexed-test-data-tuple
    (lambda (callback)
        (for-each
            (lambda (tuple index)
                (apply
                    callback
                    (cons index tuple)))
            TEST-DATA-TUPLES
            (iota (length TEST-DATA-TUPLES)))))

(define test-encode
    (lambda ()
        (test-section "encode")
        (for-each-indexed-test-data-tuple
            (lambda (index xs encoded)
                (test*
                    (format "#~d" (+ index 1))
                    encoded
                    (encode xs))))))

(define test-decode
    (lambda ()
        (test-section "decode")
        (for-each-indexed-test-data-tuple
            (lambda (index xs encoded)
                (test*
                    (format "#~d" (+ index 1))
                    xs
                    (decode encoded))))))

