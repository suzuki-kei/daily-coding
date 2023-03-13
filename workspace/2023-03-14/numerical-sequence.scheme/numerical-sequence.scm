
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

(define fizzbuzz
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

