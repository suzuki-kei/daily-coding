
(define my-fold
    (lambda (procedure default xs)
        (cond
            ((null? xs)
                default)
            (else
                (my-fold
                    procedure
                    (procedure (car xs) default)
                    (cdr xs))))))

