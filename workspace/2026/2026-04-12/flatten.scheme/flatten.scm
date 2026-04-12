
(define flatten/non-tailrec
    (lambda (xs)
        (define accumulate
            (lambda (xs)
                (cond
                    ((null? xs)
                        '())
                    ((atom? (car xs))
                        (cons
                            (car xs)
                            (accumulate (cdr xs))))
                    (else
                        (append
                            (accumulate (car xs))
                            (accumulate (cdr xs)))))))
        (accumulate xs)))

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

(define atom?
    (lambda (x)
        (and
            (not (null? x))
            (not (pair? x)))))

