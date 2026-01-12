
(define prefixes
    (lambda (xs :optional (reversed-prefix '()) (reversed-prefixes '()))
        (cond
            ((null? xs)
                (reverse
                    (cons (reverse reversed-prefix) reversed-prefixes)))
            (else
                (prefixes
                    (cdr xs)
                    (cons (car xs) reversed-prefix)
                    (cons (reverse reversed-prefix) reversed-prefixes))))))

(define proper-prefixes
    (lambda (xs :optional (reversed-prefix '()) (reversed-prefixes '()))
        (cond
            ((null? xs)
                '())
            ((null? (cdr xs))
                (reverse
                    (cons (reverse reversed-prefix) reversed-prefixes)))
            (else
                (proper-prefixes
                    (cdr xs)
                    (cons (car xs) reversed-prefix)
                    (cons (reverse reversed-prefix) reversed-prefixes))))))

(define suffixes
    (lambda (xs)
        (map
            reverse
            (prefixes
                (reverse xs)))))

(define proper-suffixes
    (lambda (xs)
        (map
            reverse
            (proper-prefixes
                (reverse xs)))))

(define longer
    (lambda (xs ys)
        (if (> (length xs) (length ys))
            xs
            ys)))

(define intersection
    (lambda (xs ys)
        (filter
            (lambda (x)
                (include? x ys))
            xs)))

(define include?
    (lambda (x xs)
        (cond
            ((null? xs)
                #f)
            (else
                (or
                    (equal? x (car xs))
                    (include? x (cdr xs)))))))

(define lps
    (lambda (xs)
        (fold
            longer
            '()
            (intersection
                (proper-prefixes xs)
                (proper-suffixes xs)))))

(define lps-array
    (lambda (xs)
        (map
            length
            (map
                lps
                (cdr (prefixes xs))))))

