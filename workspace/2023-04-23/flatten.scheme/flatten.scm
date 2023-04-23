
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
                (list x))
            (else
                (append
                    (flatten (car x))
                    (flatten (cdr x)))))))

