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
    (lambda (separator xs :optional (accumulated '()))
        (cond
            ((null? xs)
                (reverse accumulated))
            ((null? accumulated)
                (intersperse
                    separator
                    (drop xs 1)
                    (take xs 1)))
            (else
                (intersperse
                    separator
                    (cdr xs)
                    (cons*
                        (car xs)
                        separator
                        accumulated))))))

(define factorial
    (lambda (n :optional (fn 1))
        (cond
            ((= n 0)
                fn)
            (else
                (factorial
                    (- n 1)
                    (* fn n))))))

(define fibonacci
    (lambda (n :optional (a 0) (b 1))
        (cond
            ((= n 0)
                a)
            (else
                (fibonacci
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

