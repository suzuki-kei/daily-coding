
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

(define my-fold-right
    (lambda (f x xs)
        (cond
            ((null? xs)
                x)
            ((null? (cdr xs))
                (f (car xs) x))
            (else
                (f
                    (car xs)
                    (my-fold-right
                        f
                        x
                        (cdr xs)))))))

