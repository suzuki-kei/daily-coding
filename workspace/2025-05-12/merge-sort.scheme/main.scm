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
        (cond
            ((sorted? xs)
                (print (xs->string " " xs) " (sorted)"))
            (else
                (print (xs->string " " xs) " (not sorted)")))))

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
        (string-join
            (map x->string xs)
            separator)))

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

