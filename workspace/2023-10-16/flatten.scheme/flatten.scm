
(define flatten
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            ((list? (car xs))
                (append
                    (flatten (car xs))
                    (flatten (cdr xs))))
            (else
                (cons
                    (car xs)
                    (flatten (cdr xs)))))))

