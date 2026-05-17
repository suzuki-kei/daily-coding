
(define flatten/tailrec
    (lambda (xs)
        (define accumulate
            (lambda (xs stack flatten)
                (cond
                    ((null? xs)
                        (cond
                            ((null? stack)
                                (reverse flatten))
                            (else
                                (accumulate
                                    (car stack)
                                    (cdr stack)
                                    flatten))))
                    ((atom? (car xs))
                        (accumulate
                            (cdr xs)
                            stack
                            (cons (car xs) flatten)))
                    (else
                        (accumulate
                            (car xs)
                            (cons (cdr xs) stack)
                            flatten)))))
        (accumulate xs '() '())))

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

(define atom?
    (lambda (x)
        (and
            (not (null? x))
            (not (pair? x)))))

