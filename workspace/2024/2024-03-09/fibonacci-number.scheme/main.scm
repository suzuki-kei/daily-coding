
(define main
    (lambda (_)
        (print-fibonacci-numbers 100)
        0))

(define print-fibonacci-numbers
    (lambda (n)
        (for-each
            (lambda (n)
                (print
                    (format
                        "fibonacci(~w) = ~w"
                        n
                        (fibonacci n))))
            (iota (+ n 1)))))

(define fibonacci
    (lambda (n)
        (fibonacci.tailrec n 0 1)))

(define fibonacci.tailrec
    (lambda (n a b)
        (cond
            ((= n 0)
                a)
            (else
                (fibonacci.tailrec
                    (- n 1)
                    b
                    (+ a b))))))

