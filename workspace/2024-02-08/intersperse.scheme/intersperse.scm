
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
                (reverse accumulated))
            ((null? accumulated)
                (intersperse.tailrec
                    separator
                    (cdr xs)
                    (list (car xs))))
            (else
                (intersperse.tailrec
                    separator
                    (cdr xs)
                    (cons*
                        (car xs)
                        separator
                        accumulated))))))

