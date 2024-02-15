(use srfi-13)

(define main
    (lambda (_)
        (print-sequence "factorials" factorial 1 10)
        (print-sequence "fibonacci numbers" fibonacci 0 20)
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

(define xs->string
    (lambda (separator xs)
        (string-concatenate
            (map
                x->string
                (intersperse separator xs)))))

(define sequence
    (lambda (min max)
        (iota
            (+
                (- max min)
                1)
            min)))

(define factorial
    (lambda (n)
        (factorial.tailrec 1 n)))

(define factorial.tailrec
    (lambda (accumulated n)
        (cond
            ((= n 0)
                accumulated)
            (else
                (factorial.tailrec
                    (* accumulated n)
                    (- n 1))))))

(define fibonacci
    (lambda (n)
        (fibonacci.tailrec 0 1 n)))

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

