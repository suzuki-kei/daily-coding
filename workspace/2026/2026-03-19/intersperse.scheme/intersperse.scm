
(define intersperse
    (lambda (separator xs)
        (define intersperse
            (lambda (separator xs interspersed)
                (cond
                    ((null? xs)
                        (cdr
                            (reverse interspersed)))
                    (else
                        (intersperse
                            separator
                            (cdr xs)
                            (cons* (car xs) separator interspersed))))))
        (cond
            ((null? xs)
                '())
            (else
                (intersperse separator xs '())))))

