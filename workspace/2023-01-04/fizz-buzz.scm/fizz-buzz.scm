
(define main
    (lambda (arguments)
        (print
            (fizz-buzz 100))
        0))

(define fizz-buzz
    (lambda (n)
        (map
            fizz-buzz-value
            (iota n 1))))

(define fizz-buzz-value
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

