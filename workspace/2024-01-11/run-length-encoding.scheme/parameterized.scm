
(define parameterized
    (lambda (callback tuples)
        (for-each
            (lambda (tuple index)
                (apply
                    callback
                    (cons index tuple)))
            tuples
            (iota (length tuples) 1))))

