
(define flatten
    (lambda (x)
        (cond
            ((null? x)
                '())
            ((atom? (car x))
                (cons
                    (car x)
                    (flatten (cdr x))))
            (else
                (append
                    (flatten (car x))
                    (flatten (cdr x)))))))

(define atom?
    (lambda (x)
        (and
            (not (null? x))
            (not (pair? x)))))

