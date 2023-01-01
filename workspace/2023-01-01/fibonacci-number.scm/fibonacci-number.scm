
(define main
    (lambda (arguments)
        (print
            (map
                fibonacci-number
                (iota 20 1)))
        0))

(define fibonacci-number
    (lambda (n)
        (fibonacci-number.tailrec 0 1 n)))

(define fibonacci-number.tailrec
    (lambda (a b n)
        (cond
            ((< n 0)
                #f)
            ((= n 0)
                a)
            (else
                (fibonacci-number.tailrec
                    b
                    (+ a b)
                    (- n 1))))))

