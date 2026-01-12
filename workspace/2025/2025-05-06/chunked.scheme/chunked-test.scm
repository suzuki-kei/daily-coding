(use gauche.test)
(load "chunked")

(define main
    (lambda (_)
        (test-start "chunked")
        (test-chunked)
        (test-end)))

(define TEST-DATA-TUPLES '(
    ; (list chunk-size chunked-list)
    (() 1 ())
    (() 2 ())
    (() 3 ())
    ((a) 1 ((a)))
    ((a) 2 ((a)))
    ((a) 3 ((a)))
    ((a b) 1 ((a) (b)))
    ((a b) 2 ((a b)))
    ((a b) 3 ((a b)))
    ((a b c d e f g) 1 ((a) (b) (c) (d) (e) (f) (g)))
    ((a b c d e f g) 2 ((a b) (c d) (e f) (g)))
    ((a b c d e f g) 3 ((a b c) (d e f) (g)))
    ((a b c d e f g) 4 ((a b c d) (e f g)))
    ((a b c d e f g) 5 ((a b c d e) (f g)))
    ((a b c d e f g) 6 ((a b c d e f) (g)))
    ((a b c d e f g) 7 ((a b c d e f g)))
    ((a b c d e f g) 8 ((a b c d e f g)))))

(define for-each-test-data-tuple
    (lambda (callback)
        (for-each
            (lambda (tuple index)
                (apply
                    callback
                    (cons index tuple)))
            TEST-DATA-TUPLES
            (iota (length TEST-DATA-TUPLES)))))

(define test-chunked
    (lambda ()
        (test-section "chunked")
        (for-each-test-data-tuple
            (lambda (index xs chunk-size chunked-xs)
                (test*
                    (format "#~d" (+ index 1))
                    chunked-xs
                    (chunked xs chunk-size))))))

