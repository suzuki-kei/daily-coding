
(define prefixes
    (lambda (xs)
        (prefixes.tailrec xs '() '())))

(define prefixes.tailrec
    (lambda (xs reversed-prefix reversed-prefixes)
        (cond
            ((null? xs)
                (reverse
                    (map
                        reverse
                        (cons reversed-prefix reversed-prefixes))))
            (else
                (prefixes.tailrec
                    (cdr xs)
                    (cons (car xs) reversed-prefix)
                    (cons reversed-prefix reversed-prefixes))))))

(define proper-prefixes
    (lambda (xs)
        (proper-prefixes.tailrec xs '() '())))

(define proper-prefixes.tailrec
    (lambda (xs reversed-prefix reversed-prefixes)
        (cond
            ((null? xs)
                (reverse
                    (map reverse reversed-prefixes)))
            (else
                (proper-prefixes.tailrec
                    (cdr xs)
                    (cons (car xs) reversed-prefix)
                    (cons reversed-prefix reversed-prefixes))))))

(define suffixes
    (lambda (xs)
        (suffixes.tailrec xs '())))

(define suffixes.tailrec
    (lambda (xs suffixes)
        (cond
            ((null? xs)
                (cons xs suffixes))
            (else
                (suffixes.tailrec
                    (cdr xs)
                    (cons xs suffixes))))))

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
                (include?
                    x
                    (cdr xs))))))

(define lps-array
    (lambda (xs)
        (map
            (lambda (prefix)
                (length
                    (lps prefix)))
            (cdr (prefixes xs)))))

