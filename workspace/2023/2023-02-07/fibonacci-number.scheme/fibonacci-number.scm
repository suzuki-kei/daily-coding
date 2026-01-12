
(define fibonacci
    (lambda (n)
        (fibonacci.tailrec
            0 1 n)))

(define fibonacci.tailrec
    (lambda (a b n)
        (cond
            ((= n 0)
                a)
            (else
                (fibonacci.tailrec
                    b
                    (+ a b)
                    (- n 1))))))

