(use srfi-27)

(define main
    (lambda (arguments)
        (random-source-randomize!
            default-random-source)
        (let ((xs (generate-random-values 20)))
            (print xs)
            (print (quick-sort xs)))
        0))

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
                    (if (< (car xs) pivot) (cons (car xs) less-xs) less-xs)
                    (if (= (car xs) pivot) (cons (car xs) equal-xs) equal-xs)
                    (if (> (car xs) pivot) (cons (car xs) greater-xs) greater-xs)
                    pivot
                    (cdr xs))))))

