(load "run-length-encoding")
(use gauche.test)

(define TEST-DATA-TUPLES '(
    ; (xs encoded-runs)
    (()            ())
    ((a)           ((a . 1)))
    ((a a)         ((a . 2)))
    ((a a a)       ((a . 3)))
    ((a b)         ((a . 1) (b . 1)))
    ((a b b)       ((a . 1) (b . 2)))
    ((a a b)       ((a . 2) (b . 1)))
    ((a a b c c c) ((a . 2) (b . 1) (c . 3)))))

(define for-each-test-data
    (lambda (callback)
        (for-each
            (lambda (index-with-tuple)
                (apply callback index-with-tuple))
            (map
                cons
                (iota (length TEST-DATA-TUPLES))
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
                    (format "#~d" (+ index 1))
                    encoded-runs
                    (encode xs))))))

(define test-decode
    (lambda ()
        (test-section "decode")
        (for-each-test-data
            (lambda (index xs encoded-runs)
                (test*
                    (format "#~d" (+ index 1))
                    xs
                    (decode encoded-runs))))))

