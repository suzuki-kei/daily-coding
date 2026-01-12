(use srfi-13)
(use srfi-27)

(define main
    (lambda (_)
        (initialize)
        (demonstration)
        0))

(define initialize
    (lambda ()
        (random-source-randomize! default-random-source)))

(define demonstration
    (lambda ()
        (let ((xs (generate-random-values 20)))
            (print-xs xs)
            (print-xs (merge-sort xs)))))

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (+
                    (random-integer 90)
                    10))
            (iota n))))

(define print-xs
    (lambda (xs)
        (if (sorted? xs)
            (print (xs->string " " xs) " (sorted)")
            (print (xs->string " " xs) " (not sorted)"))))

(define sorted?
    (lambda (xs)
        (cond
            ((null? xs)
                #t)
            ((null? (cdr xs))
                #t)
            ((> (car xs) (cadr xs))
                #f)
            (else
                (sorted? (cdr xs))))))

(define xs->string
    (lambda (separator xs)
        (string-concatenate
            (map
                x->string
                (intersperse separator xs)))))

(define intersperse
    (lambda (separator xs)
        (define intersperse
            (lambda (separator xs accumulated)
                (cond
                    ((null? xs)
                        (reverse
                            (cdr accumulated)))
                    (else
                        (intersperse
                            separator
                            (cdr xs)
                            (cons* separator (car xs) accumulated))))))
        (intersperse separator xs '())))

(define merge-sort
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            ((null? (cdr xs))
                (list (car xs)))
            (else
                (merge
                    (merge
                        (list (car xs))
                        (list (cadr xs)))
                    (merge-sort
                        (cddr xs)))))))

(define merge
    (lambda (xs ys)
        (define merge
            (lambda (xs ys accumulated)
                (cond
                    ((or (null? xs) (null? ys))
                        (append
                            (reverse accumulated)
                            xs
                            ys))
                    ((< (car xs) (car ys))
                        (merge
                            (cdr xs)
                            ys
                            (cons (car xs) accumulated)))
                    (else
                        (merge
                            xs
                            (cdr ys)
                            (cons (car ys) accumulated))))))
        (merge xs ys '())))


