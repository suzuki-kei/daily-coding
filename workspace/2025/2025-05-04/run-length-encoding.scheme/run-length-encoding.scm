
(define encode
    (lambda (xs)
        (xs->encoded-runs xs)))

(define xs->encoded-runs
    (lambda (xs)
        (runs->encoded-runs
            (xs->runs xs))))

(define runs->encoded-runs
    (lambda (runs)
        (map run->encoded-run runs)))

(define run->encoded-run
    (lambda (run)
        (cons
            (car run)
            (length run))))

(define xs->runs
    (lambda (xs)
        (define accumulate
            (lambda (xs run runs)
                (cond
                    ((null? xs)
                        (reverse
                            (cons run runs)))
                    ((equal? (car xs) (car run))
                        (accumulate
                            (cdr xs)
                            (cons (car xs) run)
                            runs))
                    (else
                        (accumulate
                            (cdr xs)
                            (list (car xs))
                            (cons run runs))))))
        (cond
            ((null? xs)
                '())
            (else
                (accumulate
                    (cdr xs)
                    (list (car xs))
                    '())))))

(define decode
    (lambda (encoded-runs)
        (encoded-runs->xs encoded-runs)))

(define encoded-runs->xs
    (lambda (encoded-runs)
        (runs->xs
            (encoded-runs->runs encoded-runs))))

(define encoded-runs->runs
    (lambda (encoded-runs)
        (map
            encoded-run->run
            encoded-runs)))

(define encoded-run->run
    (lambda (encoded-run)
        (accumulate
            (car encoded-run)
            (cdr encoded-run)
            '())))

(define accumulate
    (lambda (x n run)
        (cond
            ((= n 0)
                run)
            (else
                (accumulate
                    x
                    (- n 1)
                    (cons x run))))))

(define runs->xs
    (lambda (runs)
        (define accumulate
            (lambda (runs xs)
                (cond
                    ((null? runs)
                        xs)
                    (else
                        (accumulate
                            (cdr runs)
                            (append xs (car runs)))))))
        (accumulate runs '())))

