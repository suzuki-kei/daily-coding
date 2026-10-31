(import (scheme base))
(import (scheme write))
(import (srfi 1))
(import (srfi 8))
(import (srfi 13))
(import (srfi 27))
(import (srfi 28))

(define main
    (lambda ()
        (initialize)
        (demonstration)
        0))

(define initialize
    (lambda ()
        (random-source-randomize! default-random-source)))

(define demonstration
    (lambda ()
        (let ((xs (generate-random-values 20 10 99)))
            (print-xs xs)
            (print-xs (quick-sort xs)))))

(define generate-random-values
    (lambda (n min max)
        (map
            (lambda (_)
                (random-range min max))
            (iota n))))

(define random-range
    (lambda (min max)
        (+
            (random-integer
                (+ (- max min) 1))
            min)))

(define print-xs
    (lambda (xs)
        (define xs->string
            (lambda (separator xs)
                (string-join
                    (map number->string xs)
                    separator)))
        (define xs->sorted-label
            (lambda (xs)
                (cond
                    ((sorted? xs)
                        "sorted")
                    (else
                        "not sorted"))))
        (display
            (format
                "~a (~a)~%"
                (xs->string " " xs)
                (xs->sorted-label xs)))))

(define sorted?
    (lambda (xs)
        (cond
            ((null? xs)
                #t)
            ((null? (cdr xs))
                #t)
            ((> (car xs) (cadr xs))
                #f)
            (else
                (sorted? (cdr xs))))))

(define intersperse
    (lambda (separator xs)
        (define accumulate
            (lambda (separator xs interspersed)
                (cond
                    ((null? xs)
                        (cdr
                            (reverse interspersed)))
                    (else
                        (accumulate
                            separator
                            (cdr xs)
                            (cons* (car xs) separator interspersed))))))
        (accumulate separator xs '())))

(define print
    (lambda (x)
        (display x)
        (newline)))

(define quick-sort
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            (else
                (receive
                    (less-xs equal-xs greater-xs)
                    (partition-3way (car xs) xs)
                    (append
                        (quick-sort less-xs)
                        equal-xs
                        (quick-sort greater-xs)))))))

(define partition-3way
    (lambda (pivot xs)
        (define accumulate
            (lambda (pivot xs less-xs equal-xs greater-xs)
                (cond
                    ((null? xs)
                        (values less-xs equal-xs greater-xs))
                    ((< (car xs) pivot)
                        (accumulate
                            pivot
                            (cdr xs)
                            (cons (car xs) less-xs)
                            equal-xs
                            greater-xs))
                    ((> (car xs) pivot)
                        (accumulate
                            pivot
                            (cdr xs)
                            less-xs
                            equal-xs
                            (cons (car xs) greater-xs)))
                    (else
                        (accumulate
                            pivot
                            (cdr xs)
                            less-xs
                            (cons (car xs) equal-xs)
                            greater-xs)))))
        (accumulate pivot xs '() '() '())))

(main)

