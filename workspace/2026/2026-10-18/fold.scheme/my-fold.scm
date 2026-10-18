
(define my-fold
    (lambda (f x xs)
        (cond
            ((null? xs)
                x)
            (else
                (my-fold
                    f
                    (f (car xs) x)
                    (cdr xs))))))

