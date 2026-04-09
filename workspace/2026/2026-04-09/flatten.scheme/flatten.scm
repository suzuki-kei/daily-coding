
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

(define flatten/tailrec
    (lambda (xs)
        (define flatten
            (lambda (xs accumulator)
                (cond
                    ((null? xs)
                        accumulator)
                    ((atom? (car xs))
                        (flatten
                            (cdr xs)
                            (cons (car xs) accumulator)))
                    (else
                        (flatten
                            (cdr xs)
                            (flatten (car xs) accumulator))))))
        (reverse
            (flatten xs '()))))

(define atom?
    (lambda (x)
        (and
            (not (null? x))
            (not (pair? x)))))

