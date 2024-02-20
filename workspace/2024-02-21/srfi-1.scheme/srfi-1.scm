
(define xcons
    (lambda (xs x)
        (cons x xs)))

(define cons*
    (lambda (x . xs)
        (cond
            ((null? xs)
                x)
            (else
                (cons
                    x
                    (apply cons* xs))))))

(define make-list
    (lambda (n x)
        (make-list.tailrec n x '())))

(define make-list.tailrec
    (lambda (n x accumulated)
        (cond
            ((= n 0)
                accumulated)
            (else
                (make-list.tailrec
                    (- n 1)
                    x
                    (cons x accumulated))))))

(define list-tabulate
    (lambda (n f)
        (map
            f
            (iota n))))

(define list-copy
    (lambda (xs)
        (map values xs)))

(define circular-list
    (lambda (x . xs)
        (let ((ys (cons x xs)))
            (circular-list.tailrec ys ys))))

(define circular-list.tailrec
    (lambda (head xs)
        (cond
            ((null? (cdr xs))
                (set-cdr! xs head)
                head)
            (else
                (circular-list.tailrec
                    head
                    (cdr xs))))))

(define iota
    (lambda (n :optional (start 0) (step 1))
        (iota.tailrec n start step '())))

(define iota.tailrec
    (lambda (n next step accumulated)
        (cond
            ((= n 0)
                (reverse accumulated))
            (else
                (iota.tailrec
                    (- n 1)
                    (+ next step)
                    step
                    (cons next accumulated))))))

