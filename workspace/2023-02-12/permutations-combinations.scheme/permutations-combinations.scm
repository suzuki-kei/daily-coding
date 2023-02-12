(load "set")

(define atom?
    (lambda (x)
        (and
            (not (null? x))
            (not (pair? x)))))

(define flatten?
    (lambda (x)
        (or
            (atom? x)
            (every atom? x))))

(define flatten
    (lambda (xs flatten?)
        (cond
            ((null? xs)
                '())
            ((flatten? xs)
                xs)
            ((flatten? (car xs))
                (cons
                    (car xs)
                    (flatten (cdr xs) flatten?)))
            (else
                (append
                    (flatten (car xs) flatten?)
                    (flatten (cdr xs) flatten?))))))

(define remove-nth
    (lambda (xs n)
        (remove-nth.tailrec
            '() xs n)))

(define remove-nth.tailrec
    (lambda (leading-values xs n)
        (cond
            ((null? xs)
                (error))
            ((= n 0)
                (values
                    (append
                        (reverse leading-values)
                        (cdr xs))
                    (car xs)))
            (else
                (remove-nth.tailrec
                    (cons (car xs) leading-values)
                    (cdr xs)
                    (- n 1))))))

(define map-with-nth-element
    (lambda (mapper xs)
        (map
            (lambda (nth)
                (receive
                    (ys x)
                    (remove-nth xs nth)
                    (mapper x ys)))
            (iota (length xs)))))

(define permutations
    (lambda (xs n)
        (flatten
            (permutations.tailrec
                '() xs n)
            flatten?)))

(define permutations.tailrec
    (lambda (leading-values xs n)
        (cond
            ((= n 0)
                (list
                    (reverse leading-values)))
            ((and (> n 1) (< n (length xs)))
                (map-with-nth-element
                    (lambda (x ys)
                        (permutations.tailrec
                            leading-values
                            ys
                            n))
                    xs))
            (else
                (map-with-nth-element
                    (lambda (x ys)
                        (permutations.tailrec
                            (cons x leading-values)
                            ys
                            (- n 1)))
                    xs)))))

(define combinations
    (lambda (xs n)
        (flatten
            (combinations.tailrec
                '() xs n)
            flatten?)))

(define combinations.tailrec
    (lambda (leading-values xs n)
        (cond
            ((= n 0)
                (list
                    (reverse leading-values)))
            ((< n (length xs))
                (append
                    (combinations.tailrec
                        (cons (car xs) leading-values)
                        (cdr xs)
                        (- n 1))
                    (combinations.tailrec
                        leading-values
                        (cdr xs)
                        n)))
            (else
                (combinations.tailrec
                    (cons (car xs) leading-values)
                    (cdr xs)
                    (- n 1))))))

