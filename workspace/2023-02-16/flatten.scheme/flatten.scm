
(define atom?
    (lambda (x)
        (and
            (not (null? x))
            (not (pair? x)))))

(define flatten
    (lambda (x)
        (cond
            ((null? x)
                '())
            ((atom? x)
                x)
            ((atom? (car x))
                (cons
                    (flatten (car x))
                    (flatten (cdr x))))
            (else
                (append
                    (flatten (car x))
                    (flatten (cdr x)))))))

