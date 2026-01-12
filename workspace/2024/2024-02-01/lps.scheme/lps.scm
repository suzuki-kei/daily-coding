
(define prefixes
    (lambda (xs)
        (prefixes.tailrec '() '() xs)))

(define prefixes.tailrec
    (lambda (prefixes prefix xs)
        (cond
            ((null? xs)
                (reverse
                    (cons
                        prefix
                        prefixes)))
            (else
                (prefixes.tailrec
                    (cons prefix prefixes)
                    (append prefix (take xs 1))
                    (cdr xs))))))

(define proper-prefixes
    (lambda (xs)
        (proper-prefixes.tailrec '() '() xs)))

(define proper-prefixes.tailrec
    (lambda (prefixes prefix xs)
        (cond
            ((null? xs)
                (reverse prefixes))
            (else
                (proper-prefixes.tailrec
                    (cons prefix prefixes)
                    (append prefix (take xs 1))
                    (cdr xs))))))

(define suffixes
    (lambda (xs)
        (map
            reverse
            (prefixes (reverse xs)))))

(define proper-suffixes
    (lambda (xs)
        (map
            reverse
            (proper-prefixes (reverse xs)))))

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

; lps: longest prefix which also suffix
(define lps
    (lambda (xs)
        (define longer
            (lambda (xs ys)
                (if (> (length xs) (length ys))
                    xs
                    ys)))
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

