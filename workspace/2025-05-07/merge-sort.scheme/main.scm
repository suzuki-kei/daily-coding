(use srfi-13)
(use srfi-27)

(define main
    (lambda (_)
        (initialize)
        (demonstration)
        0))

(define initialize
    (lambda ()
        (random-source-randomize! default-random-source)))

(define demonstration
    (lambda ()
        (let ((xs (generate-random-values 20)))
            (print-xs xs)
            (print-xs (merge-sort xs)))))

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (+
                    (random-integer 90)
                    10))
            (iota n))))

(define print-xs
    (lambda (xs)
        (if (sorted? xs)
            (print (xs->string " " xs) " (sorted)")
            (print (xs->string " " xs) " (not sorted)"))))

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

(define xs->string
    (lambda (separator xs)
        (string-concatenate
            (map
                x->string
                (intersperse separator xs)))))

(define intersperse
    (lambda (separator xs)
        (define accumulate
            (lambda (separator xs interspersed)
                (cond
                    ((null? xs)
                        (reverse
                            (cdr interspersed)))
                    (else
                        (accumulate
                            separator
                            (cdr xs)
                            (cons* separator (car xs) interspersed))))))
        (if (null? xs)
            '()
            (accumulate separator xs '()))))

(define reverse
    (lambda (xs)
        (define accumulate
            (lambda (xs reversed)
                (cond
                    ((null? xs)
                        reversed)
                    (else
                        (accumulate
                            (cdr xs)
                            (cons (car xs) reversed))))))
        (accumulate xs '())))

(define cons*
    (lambda xs
        (cond
            ((null? (cdr xs))
                (car xs))
            (else
                (cons
                    (car xs)
                    (apply cons* (cdr xs)))))))

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
        (let ((n (quotient (length xs) 2)))
            (values
                (take xs n)
                (drop xs n)))))

