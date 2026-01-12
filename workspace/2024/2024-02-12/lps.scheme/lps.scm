
(define prefixes
    (lambda (xs)
        (prefixes.tailrec xs '() '())))

(define prefixes.tailrec
    (lambda (xs prefix prefixes)
        (cond
            ((null? xs)
                (append
                    prefixes
                    (list prefix)))
            (else
                (prefixes.tailrec
                    (cdr xs)
                    (append
                        prefix
                        (list (car xs)))
                    (append
                        prefixes
                        (list prefix)))))))

(define proper-prefixes
    (lambda (xs)
        (proper-prefixes.tailrec xs '() '())))

(define proper-prefixes.tailrec
    (lambda (xs prefix prefixes)
        (cond
            ((null? xs)
                prefixes)
            (else
                (proper-prefixes.tailrec
                    (cdr xs)
                    (append
                        prefix
                        (list (car xs)))
                    (append
                        prefixes
                        (list prefix)))))))

(define suffixes
    (lambda (xs)
        (suffixes.tailrec xs '())))

(define suffixes.tailrec
    (lambda (xs suffixes)
        (cond
            ((null? xs)
                (cons '() suffixes))
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
            ((equal? (car xs) x)
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
            (cdr
                (prefixes xs)))))

