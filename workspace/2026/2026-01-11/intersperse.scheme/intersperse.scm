
(define intersperse.fold
    (lambda (separator xs)
        (cond
            ((null? xs)
                '())
            (else
                (cdr
                    (reverse
                        (fold
                            (lambda (x xs)
                                (cons* x separator xs))
                            '()
                            xs)))))))

(define intersperse.recursive
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

