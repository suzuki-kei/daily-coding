
(define intersperse
    (lambda (separator xs :optional (accumulated '()))
        (cond
            ((null? xs)
                (reverse accumulated))
            ((null? accumulated)
                (intersperse
                    separator
                    (drop xs 1)
                    (take xs 1)))
            (else
                (intersperse
                    separator
                    (cdr xs)
                    (cons*
                        (car xs)
                        separator
                        accumulated))))))

