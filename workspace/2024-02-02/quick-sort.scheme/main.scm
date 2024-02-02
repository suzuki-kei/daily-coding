(use srfi-13)
(use srfi-27)

(define main
    (lambda (_)
        (random-source-randomize!
            default-random-source)
        (let ((xs (generate-random-values 20)))
            (print-sequence xs)
            (print-sequence (quick-sort xs)))
        0))

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (+ (random-integer 90) 10))
            (iota n))))

(define print-sequence
    (lambda (xs)
        (cond
            ((sorted? xs)
                (print
                    (format
                        "~a (sorted)"
                        (xs->string " " xs))))
            (else
                (print
                    (format
                        "~a (not sorted)"
                        (xs->string " " xs)))))))

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
        (partition.tailrec '() '() '() pivot xs)))

(define partition.tailrec
    (lambda (less-xs equal-xs greater-xs pivot xs)
        (cond
            ((null? xs)
                (values less-xs equal-xs greater-xs))
            (else
                (partition.tailrec
                    (cons-if < (car xs) pivot less-xs)
                    (cons-if = (car xs) pivot equal-xs)
                    (cons-if > (car xs) pivot greater-xs)
                    pivot
                    (cdr xs))))))

(define cons-if
    (lambda (predicate x pivot xs)
        (cond
            ((predicate x pivot)
                (cons x xs))
            (else
                xs))))

