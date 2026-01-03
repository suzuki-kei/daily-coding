
(define intersperse
    (lambda (separator xs)
        (cond
            ((null? xs)
                '())
            (else
                (cdr
                    (reverse
                        (fold-left
                            (lambda (xs x)
                                (cons* x separator xs))
                            '()
                            xs)))))))

