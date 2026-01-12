
(define intersperse
    (lambda (separator xs)
        (define accumulate
            (lambda (separator xs interspersed)
                (cond
                    ((null? xs)
                        (cdr
                            (reverse interspersed)))
                    (else
                        (accumulate
                            separator
                            (cdr xs)
                            (cons* (car xs) separator interspersed))))))
        (cond
            ((null? xs)
                '())
            (else
                (accumulate separator xs '())))))

