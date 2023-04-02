
(define main
    (lambda (arguments)
        (print "factorials:")
        (print (map factorial (range 0 10)))
        (print "fibonacci numbers:")
        (print (map fibonacci (range 0 20)))
        (print "FizzBuzz values:")
        (print (map fizzbuzz (range 1 100)))
        0))

(define range
    (lambda (minimum maximum)
        (iota
            (+
                1
                (- maximum minimum))
            minimum)))

(define factorial
    (lambda (n)
        (factorial.tailrec 1 n)))

(define factorial.tailrec
    (lambda (factorial n)
        (cond
            ((= n 0)
                factorial)
            (else
                (factorial.tailrec
                    (* n factorial)
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

