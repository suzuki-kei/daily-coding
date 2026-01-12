
(define take
    (lambda (xs n)
        (take.tailrec xs n '())))

(define take.tailrec
    (lambda (xs n accumulated)
        (cond
            ((= n 0)
                (reverse accumulated))
            ((null? xs)
                (error "invalid argument"))
            (else
                (take.tailrec
                    (cdr xs)
                    (- n 1)
                    (cons (car xs) accumulated))))))

(define drop
    (lambda (xs n)
        (cond
            ((= n 0)
                xs)
            ((null? xs)
                (error "invalid argument"))
            (else
                (drop
                    (cdr xs)
                    (- n 1))))))

(define take-right
    (lambda (xs n)
        (reverse
            (take
                (reverse xs)
                n))))

(define drop-right
    (lambda (xs n)
        (reverse
            (drop
                (reverse xs)
                n))))

(define split-at
    (lambda (xs n)
        (values
            (take xs n)
            (drop xs n))))

