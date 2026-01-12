
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
                    (list (car xs))
                    separator
                    (cdr xs)))
            (else
                (intersperse.tailrec
                    (cons*
                        (car xs)
                        separator
                        accumulated)
                    separator
                    (cdr xs))))))

