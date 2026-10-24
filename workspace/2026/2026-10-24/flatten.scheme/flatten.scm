
(define flatten/tailrec
    (lambda (xs)
        (define flatten
            (lambda (xs stack flattened)
                (cond
                    ((null? xs)
                        (cond
                            ((null? stack)
                                (reverse flattened))
                            (else
                                (flatten
                                    (car stack)
                                    (cdr stack)
                                    flattened))))
                    ((atom? (car xs))
                        (flatten
                            (cdr xs)
                            stack
                            (cons (car xs) flattened)))
                    (else
                        (flatten
                            (car xs)
                            (cons (cdr xs) stack)
                            flattened)))))
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

