(use srfi-13)

(define main
    (lambda (_)
        (print-sequence "factorials" factorial 1 10)
        (print-sequence "factorials (tailrec)" factorial.tailrec 1 10)
        (print-sequence "fibonacci numbers" fibonacci 0 20)
        (print-sequence "fibonacci numbers (tailrec)" fibonacci.tailrec 0 20)
        (print-sequence "fizz buzz values" fizz-buzz 1 100)
        0))

(define print-sequence
    (lambda (description f min max)
        (print
            (format "~a:" description))
        (print
            (xs->string
                " "
                (map
                    f
                    (sequence min max))))))

(define sequence
    (lambda (min max)
        (iota
            (+ (- max min) 1)
            min)))

(define xs->string
    (lambda (separator xs)
        (string-concatenate
            (map
                x->string
                (intersperse separator xs)))))

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

(define factorial
    (lambda (n)
        (cond
            ((= n 0)
                1)
            (else
                (*
                    n
                    (factorial
                        (- n 1)))))))

(define factorial.tailrec
    (lambda (n :optional (fn 1))
        (cond
            ((= n 0)
                fn)
            (else
                (factorial.tailrec
                    (- n 1)
                    (* fn n))))))

(define fibonacci
    (lambda (n)
        (cond
            ((= n 0)
                0)
            ((= n 1)
                1)
            (else
                (+
                    (fibonacci
                        (- n 1))
                    (fibonacci
                        (- n 2)))))))

(define fibonacci.tailrec
    (lambda (n :optional (a 0) (b 1))
        (cond
            ((= n 0)
                a)
            (else
                (fibonacci.tailrec
                    (- n 1)
                    b
                    (+ a b))))))

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

