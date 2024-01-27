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
    (lambda (separator xs)
        (string-concatenate
            (intersperse
                separator
                (map x->string xs)))))

(define intersperse
    (lambda (separator xs)
        (cond
            ((null? xs)
                '())
            (else
                (intersperse.tailrec '() separator xs)))))

(define intersperse.tailrec
    (lambda (interspersed separator xs)
        (cond
            ((null? xs)
                (reverse
                    (cdr interspersed)))
            (else
                (intersperse.tailrec
                    (cons*
                        separator
                        (car xs)
                        interspersed)
                    separator
                    (cdr xs))))))

