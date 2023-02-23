
(define atom?
    (lambda (x)
        (and
            (not (null? x))
            (not (pair? x)))))

(define flatten?
    (lambda (xs)
        (every atom? xs)))

(define tree->list
    (lambda (tree leaf?)
        (cond
            ((null? tree)
                tree)
            ((leaf? tree)
                tree)
            ((leaf? (car tree))
                (cons
                    (tree->list (car tree) leaf?)
                    (tree->list (cdr tree) leaf?)))
            (else
                (append
                    (tree->list (car tree) leaf?)
                    (tree->list (cdr tree) leaf?))))))

(define remove-nth
    (lambda (xs nth)
        (remove-nth.tailrec
            '() xs nth)))

(define remove-nth.tailrec
    (lambda (leading-values xs nth)
        (cond
            ((= nth 0)
                (values
                    (append
                        (reverse leading-values)
                        (cdr xs))
                    (car xs)))
            (else
                (remove-nth.tailrec
                    (cons (car xs) leading-values)
                    (cdr xs)
                    (- nth 1))))))

(define permutations
    (lambda (xs n)
        (tree->list
            (permutations.tailrec
                '() xs n)
            flatten?)))

(define permutations.tailrec
    (lambda (leading-values xs n)
        (define remove-nth/map
            (lambda (procedure xs)
                (map
                    (lambda (nth)
                        (receive
                            (ys x)
                            (remove-nth xs nth)
                            (procedure ys x)))
                    (iota (length xs)))))
        (cond
            ((= n 0)
                (list leading-values))
            ((< 1 n (length xs))
                (remove-nth/map
                    (lambda (ys x)
                        (permutations.tailrec
                            leading-values
                            ys
                            n))
                    xs))
            (else
                (remove-nth/map
                    (lambda (ys x)
                        (permutations.tailrec
                            (cons x leading-values)
                            ys
                            (- n 1)))
                    xs)))))

(define combinations
    (lambda (xs n)
        (tree->list
            (combinations.tailrec
                '() xs n)
            flatten?)))

(define combinations.tailrec
    (lambda (leading-values xs n)
        (cond
            ((= n 0)
                (list (reverse leading-values)))
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

