(use gauche.test)
(load "run-length-encoding")

(define main
    (lambda (_)
        (test-start "run-length-encoding")
        (test-encode)
        (test-decode)
        (test-end)))

(define TEST-DATA-TUPLES '(
    ; (xs encoded-runs)
    (()            ())
    ((a)           ((a . 1)))
    ((a a)         ((a . 2)))
    ((a a a)       ((a . 3)))
    ((a b b a)     ((a . 1) (b . 2) (a . 1)))
    ((a a b c c c) ((a . 2) (b . 1) (c . 3)))))

(define for-each-test-data-tuples
    (lambda (callback)
        (for-each
            (lambda (tuple index)
                (callback
                    (car tuple)
                    (cadr tuple)
                    index))
            TEST-DATA-TUPLES
            (iota (length TEST-DATA-TUPLES) 1))))

(define test-encode
    (lambda ()
        (test-section "encode")
        (for-each-test-data-tuples
            (lambda (xs encoded-xs index)
                (test*
                    (format "#~d" index)
                    encoded-xs
                    (encode xs))))))

(define test-decode
    (lambda ()
        (test-section "decode")
        (for-each-test-data-tuples
            (lambda (xs encoded-xs index)
                (test*
                    (format "#~d" index)
                    xs
                    (decode encoded-xs))))))

