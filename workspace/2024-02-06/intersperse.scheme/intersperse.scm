
(define intersperse
    (lambda (separator xs)
        (cond
            ((null? xs)
                '())
            (else
                (intersperse.tailrec '() separator xs)))))

(define intersperse.tailrec
    (lambda (accumulated separator xs)
        (cond
            ((null? xs)
                (reverse accumulated))
            ((null? accumulated)
                (intersperse.tailrec
                    (take xs 1)
                    separator
                    (drop xs 1)))
            (else
                (intersperse.tailrec
                    (cons*
                        (car xs)
                        separator
                        accumulated)
                    separator
                    (cdr xs))))))


