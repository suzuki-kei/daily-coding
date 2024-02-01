(use srfi-13)
(use srfi-27)

(define main
    (lambda (_)
        (random-source-randomize!
            default-random-source)
        (let ((xs (generate-random-values 20)))
            (print-values xs)
            (print-values (quick-sort xs)))
        0))

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (+ (random-integer 90) 10))
            (iota n))))

(define print-values
    (lambda (xs)
        (if (sorted? xs)
            (print
                (format
                    "~a (sorted)"
                    (xs->string " " xs)))
            (print
                (format
                    "~a (not sorted)"
                    (xs->string " " xs))))))

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
    (lambda (accumulated separator xs)
        (cond
            ((null? xs)
                (reverse
                    (cdr accumulated)))
            (else
                (intersperse.tailrec
                    (cons*
                        separator
                        (car xs)
                        accumulated)
                    separator
                    (cdr xs))))))

(define sorted?
    (lambda (xs)
        (cond
            ((null? xs)
                #t)
            ((null? (cdr xs))
                #t)
            (else
                (and
                    (<= (car xs) (cadr xs))
                    (sorted? (cdr xs)))))))

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

