
(define flatten/tailrec
    (lambda (xs)
        (define flatten
            (lambda (xs stack flattened-xs)
                (cond
                    ((null? xs)
                        (cond
                            ((null? stack)
                                (reverse flattened-xs))
                            (else
                                (flatten
                                    (car stack)
                                    (cdr stack)
                                    flattened-xs))))
                    ((atom? (car xs))
                        (flatten
                            (cdr xs)
                            stack
                            (cons (car xs) flattened-xs)))
                    (else
                        (flatten
                            (car xs)
                            (cons (cdr xs) stack)
                            flattened-xs)))))
        (flatten xs '() '())))

(define flatten/non-tailrec
    (lambda (xs)
        (define flatten
            (lambda (xs)
                (cond
                    ((null? xs)
                        '())
                    ((atom? (car xs))
                        (cons
                            (car xs)
                            (flatten (cdr xs))))
                    (else
                        (append
                            (flatten (car xs))
                            (flatten (cdr xs)))))))
        (flatten xs)))

(define atom?
    (lambda (x)
        (and
            (not (null? x))
            (not (pair? x)))))

