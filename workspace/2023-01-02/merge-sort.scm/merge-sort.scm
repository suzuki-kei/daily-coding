
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
            (lambda (_) (+ (random-integer 90) 10))
            (iota n))))

(define merge-sort
    (lambda (xs)
        (cond
            ((null? xs)
                xs)
            ((null? (cdr xs))
                xs)
            (else
                (merge
                    (merge
                        (list (car xs))
                        (list (cadr xs)))
                    (merge-sort
                        (cddr xs)))))))

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
            ((> (car xs) (car ys))
                (merge.tailrec
                    (cons (car ys) merged)
                    xs
                    (cdr ys)))
            (else
                (merge.tailrec
                    (cons* (car xs) (car ys) merged)
                    (cdr xs)
                    (cdr ys))))))

