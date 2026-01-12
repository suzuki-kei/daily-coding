
(define my-fold
    (lambda (f init xs)
        (cond
            ((null? xs)
                init)
            (else
                (my-fold
                    f
                    (f (car xs) init)
                    (cdr xs))))))

