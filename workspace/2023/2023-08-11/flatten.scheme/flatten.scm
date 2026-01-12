
(define atom?
    (lambda (x)
        (and
            (not (null? x))
            (not (pair? x)))))

(define flatten
    (lambda (xs)
        (cond
            ((null? xs)
                xs)
            ((atom? (car xs))
                (cons
                    (car xs)
                    (flatten (cdr xs))))
            (else
                (append
                    (flatten (car xs))
                    (flatten (cdr xs)))))))

