
(define main
    (lambda (_)
        (for-each
            print
            (fizz-buzz-values 100))
        0))

(define fizz-buzz
    (lambda (n)
        (cond
            ((= (modulo n 15) 0)
                "FizzBuzz")
            ((= (modulo n 5) 0)
                "Buzz")
            ((= (modulo n 3) 0)
                "Fizz")
            (else
                n))))

(define fizz-buzz-values
    (lambda (n)
        (map
            fizz-buzz
            (iota n 1))))

