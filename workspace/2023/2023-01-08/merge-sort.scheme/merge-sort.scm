(use srfi-27)

(define main
    (lambda (arguments)
        (random-source-randomize!
            default-random-source)
        (let ((xs (generate-random-values 20)))
            (print xs)
            (print (merge-sort xs)))
        0))

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (+ (random-integer 90) 10))
            (iota n))))

(define merge-sort
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            ((null? (cdr xs))
                xs)
            (else
                (merge-sort-merge
                    (merge-sort-merge
                        (list (car xs))
                        (list (cadr xs)))
                    (merge-sort
                        (cddr xs)))))))

(define merge-sort-merge
    (lambda (xs ys)
        (merge-sort-merge.tailrec
            '() xs ys)))

(define merge-sort-merge.tailrec
    (lambda (merged xs ys)
        (cond
            ((or (null? xs) (null? ys))
                (reverse
                    (append
                        (reverse xs)
                        (reverse ys)
                        merged)))
            ((< (car xs) (car ys))
                (merge-sort-merge.tailrec
                    (cons (car xs) merged)
                    (cdr xs)
                    ys))
            ((> (car xs) (car ys))
                (merge-sort-merge.tailrec
                    (cons (car ys) merged)
                    xs
                    (cdr ys)))
            (else
                (merge-sort-merge.tailrec
                    (cons* (car xs) (car ys) merged)
                    (cdr xs)
                    (cdr ys))))))

