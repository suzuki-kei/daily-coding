
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
                (cdr (reverse accumulated)))
            (else
                (intersperse.tailrec
                    (cons*
                        (car xs)
                        separator
                        accumulated)
                    separator
                    (cdr xs))))))

