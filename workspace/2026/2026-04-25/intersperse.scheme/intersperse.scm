
(define intersperse/fold
    (lambda (separator xs)
        (define folder
            (lambda (x xs)
                (cons* x separator xs)))
        (cond
            ((null? xs)
                '())
            (else
                (cdr
                    (reverse
                        (fold folder '() xs)))))))

(define intersperse/tailrec
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
                            (cons*
                                (car xs)
                                separator
                                interspersed))))))
        (cond
            ((null? xs)
                '())
            (else
                (accumulate separator xs '())))))

