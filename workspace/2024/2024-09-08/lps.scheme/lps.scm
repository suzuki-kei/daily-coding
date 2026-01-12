
(define prefixes
    (lambda (xs :optional (accumulated-prefix '()) (accumulated-prefixes '()))
        (cond
            ((null? xs)
                (reverse
                    (map
                        reverse
                        (cons accumulated-prefix accumulated-prefixes))))
            (else
                (prefixes
                    (cdr xs)
                    (cons (car xs) accumulated-prefix)
                    (cons accumulated-prefix accumulated-prefixes))))))

(define proper-prefixes
    (lambda (xs :optional (accumulated-prefix '()) (accumulated-prefixes '()))
        (cond
            ((null? xs)
                (reverse
                    (map reverse accumulated-prefixes)))
            (else
                (proper-prefixes
                    (cdr xs)
                    (cons (car xs) accumulated-prefix)
                    (cons accumulated-prefix accumulated-prefixes))))))

(define suffixes
    (lambda (xs :optional (accumulated '()))
        (cond
            ((null? xs)
                (cons xs accumulated))
            (else
                (suffixes
                    (cdr xs)
                    (cons xs accumulated))))))

(define proper-suffixes
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            (else
                (suffixes (cdr xs))))))

(define lps
    (lambda (xs)
        (reduce
            longer
            '()
            (intersection
                (proper-prefixes xs)
                (proper-suffixes xs)))))

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
            ((equal? x (car xs))
                #t)
            (else
                (include? x (cdr xs))))))

(define lps-array
    (lambda (xs)
        (map
            (lambda (prefix)
                (length (lps prefix)))
            (cdr (prefixes xs)))))

