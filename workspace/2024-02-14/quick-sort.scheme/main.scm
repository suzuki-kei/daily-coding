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
            (print xs)
            (print (quick-sort xs)))))

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (+ (random-integer 90) 10))
            (iota n))))

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
        (if (predicate x pivot)
            (cons x xs)
            xs)))

