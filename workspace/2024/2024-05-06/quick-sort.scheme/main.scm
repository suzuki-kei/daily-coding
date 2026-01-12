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

(define xs->string
    (lambda (separator xs)
        (string-concatenate
            (map
                x->string
                (intersperse " " xs)))))

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
        (quick-sort-partition.tailrec pivot xs '() '() '())))

(define quick-sort-partition.tailrec
    (lambda (pivot xs less-xs equal-xs greater-xs)
        (cond
            ((null? xs)
                (values less-xs equal-xs greater-xs))
            (else
                (quick-sort-partition.tailrec
                    pivot
                    (cdr xs)
                    (cons-if < (car xs) pivot less-xs)
                    (cons-if = (car xs) pivot equal-xs)
                    (cons-if > (car xs) pivot greater-xs))))))

(define cons-if
    (lambda (predicate x pivot xs)
        (if (predicate x pivot)
            (cons x xs)
            xs)))

