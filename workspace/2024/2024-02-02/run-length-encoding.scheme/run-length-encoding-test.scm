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

(define for-each-test-data
    (lambda (callback)
        (for-each
            (lambda (indexed-tuple)
                (apply callback indexed-tuple))
            (map
                cons
                (iota (length TEST-DATA-TUPLES) 1)
                TEST-DATA-TUPLES))))

(define main
    (lambda (_)
        (test-all)))

(define test-all
    (lambda ()
        (test-start "run-length-encoding")
        (test-encode)
        (test-decode)
        (test-end)))

(define test-encode
    (lambda ()
        (test-section "encode")
        (for-each-test-data
            (lambda (index xs encoded-runs)
                (test*
                    (format "#~d" index)
                    encoded-runs
                    (encode xs))))))

(define test-decode
    (lambda ()
        (test-section "decode")
        (for-each-test-data
            (lambda (index xs encoded-runs)
                (test*
                    (format "#~d" index)
                    xs
                    (decode encoded-runs))))))

