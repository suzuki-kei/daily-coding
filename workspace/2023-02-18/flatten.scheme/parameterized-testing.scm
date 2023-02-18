
(define test.parameterized
    (lambda (tuples procedure)
        (for-each
            (lambda (index tuple)
                (test*
                    (format "#~d" (+ index 1))
                    (car tuple)
                    (apply procedure (cdr tuple))))
            (iota (length tuples))
            tuples)))

