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
            (print-values xs)
            (print-values (quick-sort xs)))))

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (random-integer-range 10 99))
            (iota n))))

(define random-integer-range
    (lambda (min max)
        (+
            (random-integer
                (+ (- max min) 1))
            min)))

(define print-values
    (lambda (xs)
        (print
            (format
                (if (sorted? xs)
                    "~a (sorted)"
                    "~a (not sorted)")
                (xs->string " " xs)))))

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
                (intersperse.tailrec separator xs '())))))

(define intersperse.tailrec
    (lambda (separator xs accumulated)
        (cond
            ((null? xs)
                (reverse accumulated))
            ((null? accumulated)
                (intersperse.tailrec
                    separator
                    (cdr xs)
                    (list (car xs))))
            (else
                (intersperse.tailrec
                    separator
                    (cdr xs)
                    (cons*
                        (car xs)
                        separator
                        accumulated))))))

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
        (partition.tailrec pivot xs '() '() '())))

(define partition.tailrec
    (lambda (pivot xs less-xs equal-xs greater-xs)
        (cond
            ((null? xs)
                (values less-xs equal-xs greater-xs))
            (else
                (partition.tailrec
                    pivot
                    (cdr xs)
                    (cons-if < (car xs) pivot less-xs)
                    (cons-if = (car xs) pivot equal-xs)
                    (cons-if > (car xs) pivot greater-xs))))))

(define cons-if
    (lambda (predicate x pivot xs)
        (cond
            ((predicate x pivot)
                (cons x xs))
            (else
                xs))))

