
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
                '())
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
        (remove-nth.recursion
            '() xs nth)))

(define remove-nth.recursion
    (lambda (leading-values xs nth)
        (cond
            ((= nth 0)
                (values
                    (append
                        (reverse leading-values)
                        (cdr xs))
                    (car xs)))
            (else
                (remove-nth.recursion
                    (cons (car xs) leading-values)
                    (cdr xs)
                    (- nth 1))))))

(define permutations
    (lambda (xs n)
        (tree->list
            (permutations.recursion
                '() xs n)
            flatten?)))

(define permutations.recursion
    (lambda (leading-values xs n)
        (define map/remove-nth/xs
            (lambda (procedure)
                (map
                    (lambda (nth)
                        (receive
                            (ys x)
                            (remove-nth xs nth)
                            (procedure nth ys x)))
                    (iota (length xs)))))
        (cond
            ((= n 0)
                (list
                    (reverse leading-values)))
            ((< 1 n (length xs))
                (map/remove-nth/xs
                    (lambda (nth ys x)
                        (permutations.recursion
                            leading-values
                            ys
                            n))))
            (else
                (map/remove-nth/xs
                    (lambda (nth ys x)
                        (permutations.recursion
                            (cons x leading-values)
                            ys
                            (- n 1))))))))

(define combinations
    (lambda (xs n)
        (tree->list
            (combinations.recursion
                '() xs n)
            flatten?)))

(define combinations.recursion
    (lambda (leading-values xs n)
        (cond
            ((= n 0)
                (list
                    (reverse leading-values)))
            ((= n (length xs))
                (combinations.recursion
                    (cons (car xs) leading-values)
                    (cdr xs)
                    (- n 1)))
            (else
                (append
                    (combinations.recursion
                        (cons (car xs) leading-values)
                        (cdr xs)
                        (- n 1))
                    (combinations.recursion
                        leading-values
                        (cdr xs)
                        n))))))

