(use srfi-13)

(define main
    (lambda (_)
        (print
            (xs->string
                " "
                (map
                    fizz-buzz
                    (iota 100 1))))
        0))

(define fizz-buzz
    (lambda (n)
        (cond
            ((= (modulo n 15) 0)
                'FizzBuzz)
            ((= (modulo n 5) 0)
                'Buzz)
            ((= (modulo n 3) 0)
                'Fizz)
            (else
                n))))

(define xs->string
    (lambda (delimiter xs)
        (string-concatenate
            (intersperse
                delimiter
                (map x->string xs)))))

(define intersperse
    (lambda (x xs)
        (intersperse.tailrec
            '()
            x
            xs)))

(define intersperse.tailrec
    (lambda (interspersed x xs)
        (cond
            ((null? xs)
                (reverse
                    (cdr interspersed)))
            (else
                (intersperse.tailrec
                    (cons* x (car xs) interspersed)
                    x
                    (cdr xs))))))

