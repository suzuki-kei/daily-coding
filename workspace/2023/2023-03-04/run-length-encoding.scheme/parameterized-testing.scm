
(define parameterized-test
    (lambda (callback tuples)
        (for-each
            (lambda (index tuple)
                (apply
                    callback
                    (cons index tuple)))
            (iota (length tuples))
            tuples)))

