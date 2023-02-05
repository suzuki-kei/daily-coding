
(define my-fold
    (lambda (procedure initial-value xs)
        (cond
            ((null? xs)
                initial-value)
            (else
                (my-fold
                    procedure
                    (procedure
                        (car xs)
                        initial-value)
                    (cdr xs))))))

(define sum
    (lambda (xs)
        (my-fold + 0 xs)))

(define product
    (lambda (xs)
        (my-fold * 1 xs)))

