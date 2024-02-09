
(define prefixes
    (lambda (xs)
        (prefixes.tailrec '() '() xs)))

(define prefixes.tailrec
    (lambda (prefix prefixes xs)
        (cond
            ((null? xs)
                (append
                    prefixes
                    (list prefix)))
            (else
                (prefixes.tailrec
                    (append
                        prefix
                        (list (car xs)))
                    (append
                        prefixes
                        (list prefix))
                    (cdr xs))))))

(define proper-prefixes
    (lambda (xs)
        (proper-prefixes.tailrec '() '() xs)))

(define proper-prefixes.tailrec
    (lambda (prefix prefixes xs)
        (cond
            ((null? xs)
                prefixes)
            (else
                (proper-prefixes.tailrec
                    (append
                        prefix
                        (list (car xs)))
                    (append
                        prefixes
                        (list prefix))
                    (cdr xs))))))

(define suffixes
    (lambda (xs)
        (suffixes.tailrec '() xs)))

(define suffixes.tailrec
    (lambda (suffixes xs)
        (cond
            ((null? xs)
                (cons '() suffixes))
            (else
                (suffixes.tailrec
                    (cons xs suffixes)
                    (cdr xs))))))

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
        (if (>= (length xs) (length ys))
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
                (include? x (cdr xs))))))

(define lps-array
    (lambda (xs)
        (map
            (lambda (prefix)
                (length (lps prefix)))
            (cdr (prefixes xs)))))

