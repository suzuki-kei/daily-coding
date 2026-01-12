
(define parameterized-test
    (lambda (procedure tuples)
        (for-each
            (lambda (index tuple)
                (test*
                    (format "#~d" (+ index 1))
                    (car tuple)
                    (apply procedure (cdr tuple))))
            (iota (length tuples))
            tuples)))

