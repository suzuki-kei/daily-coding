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
                (+ (random-integer 90) 1))
            (iota n))))

(define print-values
    (lambda (xs)
        (print
            (format
                (if (sorted? xs)
                    "~a (sorted)"
                    "~a (not sorted)")
                (xs->string " " xs)))))

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
    (lambda (separator xs :optional (accumulated '()))
        (cond
            ((null? xs)
                (reverse accumulated))
            ((null? accumulated)
                (intersperse
                    separator
                    (drop xs 1)
                    (take xs 1)))
            (else
                (intersperse
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
    (lambda (pivot xs :optional (less-xs '()) (equal-xs '()) (greater-xs '()))
        (cond
            ((null? xs)
                (values less-xs equal-xs greater-xs))
            (else
                (partition
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

