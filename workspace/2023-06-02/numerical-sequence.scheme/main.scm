
(define main
    (lambda (arguments)
        (print-sequence "factorials" factorial 1 10)
        (print-sequence "fibonacci numbers" fibonacci 0 20)
        (print-sequence "fizz buzz values" fizz-buzz 1 100)
        0))

(define print-sequence
    (lambda (description f min max)
        (print description ":")
        (print (map f (iota max min)))))

(define factorial
    (lambda (n)
        (cond
            ((= n 0)
                1)
            (else
                (*
                    n
                    (factorial (- n 1)))))))

(define fibonacci
    (lambda (n)
        (cond
            ((= n 0)
                0)
            ((= n 1)
                1)
            (else
                (+
                    (fibonacci (- n 1))
                    (fibonacci (- n 2)))))))

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

