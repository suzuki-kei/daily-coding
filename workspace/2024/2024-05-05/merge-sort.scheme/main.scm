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
            (print (merge-sort xs)))))

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (+
                    (random-integer 90)
                    10))
            (iota n))))

(define merge-sort
    (lambda (xs)
        (cond
            ((or (null? xs) (null? (cdr xs)))
                xs)
            (else
                (merge-sorted-list
                    (merge-sorted-list
                        (list (car xs))
                        (list (cadr xs)))
                    (merge-sort
                        (cddr xs)))))))

(define merge-sorted-list
    (lambda (xs ys)
        (merge-sorted-list.tailrec xs ys '())))

(define merge-sorted-list.tailrec
    (lambda (xs ys accumulated)
        (cond
            ((null? xs)
                (reverse
                    (append (reverse ys) accumulated)))
            ((null? ys)
                (reverse
                    (append (reverse xs) accumulated)))
            ((< (car xs) (car ys))
                (merge-sorted-list.tailrec
                    (cdr xs)
                    ys
                    (cons (car xs) accumulated)))
            (else
                (merge-sorted-list.tailrec
                    xs
                    (cdr ys)
                    (cons (car ys) accumulated))))))

