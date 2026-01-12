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
        (print
            (string-concatenate
                (list
                    (xs->string " " xs)
                    (if
                        (sorted? xs)
                        " (sorted)"
                        " (not sorted)"))))))

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
                (intersperse.tailrec '() separator xs)))))

(define intersperse.tailrec
    (lambda (interspersed separator xs)
        (cond
            ((null? xs)
                (reverse
                    (cdr interspersed)))
            (else
                (intersperse.tailrec
                    (cons*
                        separator
                        (car xs)
                        interspersed)
                    separator
                    (cdr xs))))))

(define sorted?
    (lambda (xs :optional (predicate <=))
        (cond
            ((null? xs)
                #t)
            ((null? (cdr xs))
                #t)
            ((predicate (car xs) (cadr xs))
                (sorted?
                    (cdr xs)))
            (else
                #f))))

(define quick-sort
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            (else
                (receive
                    (less-xs equal-xs greater-xs)
                    (quick-sort-partition (car xs) xs)
                    (append
                        (quick-sort less-xs)
                        equal-xs
                        (quick-sort greater-xs)))))))

(define quick-sort-partition
    (lambda (pivot xs)
        (quick-sort-partition.tailrec '() '() '() pivot xs)))

(define quick-sort-partition.tailrec
    (lambda (less-xs equal-xs greater-xs pivot xs)
        (cond
            ((null? xs)
                (values less-xs equal-xs greater-xs))
            (else
                (quick-sort-partition.tailrec
                    (cons-if < (car xs) pivot less-xs)
                    (cons-if = (car xs) pivot equal-xs)
                    (cons-if > (car xs) pivot greater-xs)
                    pivot
                    (cdr xs))))))

(define cons-if
    (lambda (f x pivot xs)
        (cond
            ((f x pivot)
                (cons x xs))
            (else
                xs))))

