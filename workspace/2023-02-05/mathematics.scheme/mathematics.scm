
(define factorial
    (lambda (n)
        (factorial.tailrec
            1 n)))

(define factorial.tailrec
    (lambda (factorial n)
        (cond
            ((= n 0)
                factorial)
            (else
                (factorial.tailrec
                    (* factorial n)
                    (- n 1))))))

(define permutation
    (lambda (n k)
        (cond
            ((< n k)
                0)
            (else
                (/
                    (factorial n)
                    (factorial (- n k)))))))

(define combination
    (lambda (n k)
        (cond
            ((< n k)
                0)
            (else
                (/
                    (permutation n k)
                    (factorial k))))))

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

(define tree->list
    (lambda (tree leaf?)
        (cond
            ((null? tree)
                tree)
            ((atom? tree)
                tree)
            ((leaf? (car tree))
                (cons
                    (car tree)
                    (tree->list (cdr tree) leaf?)))
            (else
                (append
                    (tree->list (car tree) leaf?)
                    (tree->list (cdr tree) leaf?))))))

(define permutations
    (lambda (xs n)
        (cond
            ((< (length xs) n)
                #f)
            ((= n 0)
                '())
            (else
                (tree->list
                    (permutations.tailrec '() xs n)
                    flatten?)))))

(define permutations.tailrec
    (lambda (leading-values xs n)
        (define remove-x
            (lambda (x xs)
                (remove
                    (lambda (value)
                        (equal? value x))
                    xs)))
        (cond
            ((= n 0)
                (list
                    (reverse leading-values)))
            ((= n (length xs))
                (map
                    (lambda (x)
                        (permutations.tailrec
                            (cons x leading-values)
                            (remove-x x xs)
                            (- n 1)))
                    xs))
            (else
                (map
                    (lambda (x)
                        (permutations.tailrec
                            leading-values
                            (remove-x x xs)
                            n))
                    xs)))))

(define combinations
    (lambda (xs n)
        (cond
            ((< (length xs) n)
                #f)
            ((= n 0)
                '())
            (else
                (tree->list
                    (combinations.tailrec '() xs n)
                    flatten?)))))

(define combinations.tailrec
    (lambda (leading-values xs n)
        (cond
            ((= n 0)
                (list
                    (reverse leading-values)))
            ((= n (length xs))
                (combinations.tailrec
                    (cons (car xs) leading-values)
                    (cdr xs)
                    (- n 1)))
            (else
                (append
                    (combinations.tailrec
                        (cons (car xs) leading-values)
                        (cdr xs)
                        (- n 1))
                    (combinations.tailrec
                        leading-values
                        (cdr xs)
                        n))))))

