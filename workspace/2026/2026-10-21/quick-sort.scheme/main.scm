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
        (let ((xs (generate-random-values 20 10 100)))
            (print-xs xs)
            (print-xs (quick-sort xs)))))

(define generate-random-values
    (lambda (n begin end)
        (map
            (lambda (_)
                (random-range begin end))
            (iota n))))

(define random-range
    (lambda (begin end)
        (+
            (random-integer
                (- end begin))
            begin)))

(define print-xs
    (lambda (xs)
        (display
            (format
                "~a (~a)~%"
                (xs->string " " xs)
                (xs->sorted-label xs)))))

(define xs->string
    (lambda (separator xs)
        (string-concatenate
            (map
                x->string
                (intersperse separator xs)))))

(define xs->sorted-label
    (lambda (xs)
        (cond
            ((sorted? xs)
                "sorted")
            (else
                "not sorted"))))

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

(define quick-sort
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            (else
                (receive
                    (less-xs equal-xs greater-xs)
                    (partition-3way (car xs) xs)
                    (append
                        (quick-sort less-xs)
                        equal-xs
                        (quick-sort greater-xs)))))))

(define partition-3way
    (lambda (pivot xs)
        (define accumulate
            (lambda (pivot xs less-xs equal-xs greater-xs)
                (cond
                    ((null? xs)
                        (values less-xs equal-xs greater-xs))
                    ((< (car xs) pivot)
                        (accumulate
                            pivot
                            (cdr xs)
                            (cons (car xs) less-xs)
                            equal-xs
                            greater-xs))
                    ((> (car xs) pivot)
                        (accumulate
                            pivot
                            (cdr xs)
                            less-xs
                            equal-xs
                            (cons (car xs) greater-xs)))
                    (else
                        (accumulate
                            pivot
                            (cdr xs)
                            less-xs
                            (cons (car xs) equal-xs)
                            greater-xs)))))
        (accumulate pivot xs '() '() '())))

