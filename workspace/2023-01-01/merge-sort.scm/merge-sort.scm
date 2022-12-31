
(use srfi-27)

(define main
    (lambda (arguments)
        (random-source-randomize!
            default-random-source)
        (print
            (merge-sort
                (generate-random-values 20)))
        0))

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (+ (random-integer 90) 10))
            (iota n))))

(define merge-sort
    (lambda (xs)
        (merge-sorted-lists
            (map list xs))))

(define merge-sorted-lists
    (lambda (sorted-lists)
        (cond
            ((null? sorted-lists)
                '())
            ((null? (cdr sorted-lists))
                (car sorted-lists))
            (else
                (merge
                    (merge
                        (car sorted-lists)
                        (cadr sorted-lists))
                    (merge-sorted-lists
                        (cddr sorted-lists)))))))

(define merge
    (lambda (xs ys)
        (merge.tailrec '() xs ys)))

(define merge.tailrec
    (lambda (merged xs ys)
        (cond
            ((null? xs)
                (append
                    (reverse merged)
                    ys))
            ((null? ys)
                (append
                    (reverse merged)
                    xs))
            ((< (car xs) (car ys))
                (merge.tailrec
                    (cons (car xs) merged)
                    (cdr xs)
                    ys))
            (else
                (merge.tailrec
                    (cons (car ys) merged)
                    xs
                    (cdr ys))))))

