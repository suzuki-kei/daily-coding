
(define prefixes
    (lambda (xs)
        (define accumulate-prefixes
            (lambda (xs prefix prefixes)
                (cond
                    ((null? xs)
                        (reverse
                            (cons (reverse prefix) prefixes)))
                    (else
                        (accumulate-prefixes
                            (cdr xs)
                            (cons (car xs) prefix)
                            (cons (reverse prefix) prefixes))))))
        (accumulate-prefixes xs '() '())))

(define proper-prefixes
    (lambda (xs)
        (define accumulate-proper-prefixes
            (lambda (xs prefix prefixes)
                (cond
                    ((null? xs)
                        (reverse prefixes))
                    (else
                        (accumulate-proper-prefixes
                            (cdr xs)
                            (cons (car xs) prefix)
                            (cons (reverse prefix) prefixes))))))
        (accumulate-proper-prefixes xs '() '())))

(define suffixes
    (lambda (xs)
        (define accumulate-suffixes
            (lambda (xs suffixes)
                (cond
                    ((null? xs)
                        (cons xs suffixes))
                    (else
                        (accumulate-suffixes
                            (cdr xs)
                            (cons xs suffixes))))))
        (accumulate-suffixes xs '())))

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

