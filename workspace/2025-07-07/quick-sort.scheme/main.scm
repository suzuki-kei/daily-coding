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
            (print-xs (quick-sort xs)))))

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
        (string-concatenate
            (map
                x->string
                (intersperse separator xs)))))

(define intersperse
    (lambda (separator xs)
        (cond
            ((null? xs)
                '())
            (else
                (cdr
                    (reverse
                        (fold-left
                            (lambda (xs x)
                                (cons* x separator xs))
                            '()
                            xs)))))))

(define quick-sort
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            (else
                (receive
                    (less-xs equal-xs greater-xs)
                    (partition (car xs) xs)
                    (append
                        (quick-sort less-xs)
                        equal-xs
                        (quick-sort greater-xs)))))))

(define partition
    (lambda (pivot xs)
        (define accumulate
            (lambda (pivot xs less-xs equal-xs greater-xs)
                (cond
                    ((null? xs)
                        (values less-xs equal-xs greater-xs))
                    (else
                        (accumulate
                            pivot
                            (cdr xs)
                            (cons-if < (car xs) pivot less-xs)
                            (cons-if = (car xs) pivot equal-xs)
                            (cons-if > (car xs) pivot greater-xs))))))
        (accumulate pivot xs '() '() '())))

(define cons-if
    (lambda (predicate x pivot xs)
        (cond
            ((predicate x pivot)
                (cons x xs))
            (else
                xs))))

