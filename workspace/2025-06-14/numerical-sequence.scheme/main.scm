(use srfi-13)

(define main
    (lambda (_)
        (print-sequence "factorials" factorial 1 10)
        (print-sequence "fibonacci numbers" fibonacci 0 20)
        (print-sequence "fizz buzz values" fizz-buzz 1 100)
        0))

(define print-sequence
    (lambda (description f min max)
        (display
            (format
                "~a:\n~a\n"
                description
                (xs->string " " (map f (sequence min max)))))))

(define sequence
    (lambda (min max)
        (let ((count (+ (- max min) 1))
              (start min))
            (iota count start))))

(define xs->string
    (lambda (separator xs)
        (string-concatenate
            (map
                x->string
                (intersperse separator xs)))))

(define factorial
    (lambda (n)
        (fold-left
            *
            1
            (iota n 1))))

(define fibonacci
    (lambda (n)
        (define accumulate
            (lambda (n a b)
                (cond
                    ((= n 0)
                        a)
                    (else
                        (accumulate
                            (- n 1)
                            b
                            (+ a b))))))
        (accumulate n 0 1)))

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

