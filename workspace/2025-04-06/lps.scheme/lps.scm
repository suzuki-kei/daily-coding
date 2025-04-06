
(define prefixes
    (lambda (xs)
        (define accumulate
            (lambda (xs reversed-prefix reversed-prefixes)
                (cond
                    ((null? xs)
                        (reverse
                            (map
                                reverse
                                (cons reversed-prefix reversed-prefixes))))
                    (else
                        (accumulate
                            (cdr xs)
                            (cons (car xs) reversed-prefix)
                            (cons reversed-prefix reversed-prefixes))))))
        (accumulate xs '() '())))

(define proper-prefixes
    (lambda (xs)
        (define accumulate
            (lambda (xs reversed-prefix reversed-prefixes)
                (cond
                    ((null? xs)
                        (reverse
                            (map reverse reversed-prefixes)))
                    (else
                        (accumulate
                            (cdr xs)
                            (cons (car xs) reversed-prefix)
                            (cons reversed-prefix reversed-prefixes))))))
        (accumulate xs '() '())))

(define suffixes
    (lambda (xs)
        (define accumulate
            (lambda (xs suffixes)
                (cond
                    ((null? xs)
                        (cons xs suffixes))
                    (else
                        (accumulate
                            (cdr xs)
                            (cons xs suffixes))))))
        (accumulate xs '())))

(define proper-suffixes
    (lambda (xs)
        (if (null? xs)
            '()
            (suffixes (cdr xs)))))

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

