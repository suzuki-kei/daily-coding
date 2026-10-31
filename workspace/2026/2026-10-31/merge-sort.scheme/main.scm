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
            (print-xs (merge-sort xs)))))

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

(define merge-sort
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            ((null? (cdr xs))
                (list (car xs)))
            (else
                (receive
                    (left-xs right-xs)
                    (split xs)
                    (merge
                        (merge-sort left-xs)
                        (merge-sort right-xs)))))))

(define split
    (lambda (xs)
        (define accumulate
            (lambda (slow fast xs)
                (cond
                    ((null? fast)
                        (values
                            (reverse xs)
                            slow))
                    ((null? (cdr fast))
                        (accumulate
                            (cdr slow)
                            (cdr fast)
                            (cons (car slow) xs)))
                    (else
                        (accumulate
                            (cdr slow)
                            (cddr fast)
                            (cons (car slow) xs))))))
        (accumulate xs xs '())))

(define merge
    (lambda (xs ys)
        (define accumulate
            (lambda (xs ys merged)
                (cond
                    ((or (null? xs) (null? ys))
                        (append
                            (reverse merged)
                            xs
                            ys))
                    ((<= (car xs) (car ys))
                        (accumulate
                            (cdr xs)
                            ys
                            (cons (car xs) merged)))
                    (else
                        (accumulate
                            xs
                            (cdr ys)
                            (cons (car ys) merged))))))
        (accumulate xs ys '())))

(main)

