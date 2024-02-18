
(define intersperse
    (lambda (separator xs)
        (cond
            ((null? xs)
                '())
            (else
                (intersperse.tailrec separator xs '())))))

(define intersperse.tailrec
    (lambda (separator xs accumulated)
        (cond
            ((null? xs)
                (cdr
                    (reverse accumulated)))
            (else
                (intersperse.tailrec
                    separator
                    (cdr xs)
                    (cons*
                        (car xs)
                        separator
                        accumulated))))))

