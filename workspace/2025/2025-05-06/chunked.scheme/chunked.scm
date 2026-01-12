
(define chunked
    (lambda (xs n)
        (define accumulate
            (lambda (xs n xss)
                (cond
                    ((null? xs)
                        (reverse xss))
                    (else
                        (receive
                            (taked-xs dropped-xs)
                            (take&drop xs n)
                            (accumulate
                                dropped-xs
                                n
                                (cons taked-xs xss)))))))
        (accumulate xs n '())))

(define take&drop
    (lambda (xs n)
        (define accumulate
            (lambda (xs n dropped)
                (cond
                    ((or (= n 0) (null? xs))
                        (values
                            (reverse dropped)
                            xs))
                    (else
                        (accumulate
                            (cdr xs)
                            (- n 1)
                            (cons (car xs) dropped))))))
        (accumulate xs n '())))

