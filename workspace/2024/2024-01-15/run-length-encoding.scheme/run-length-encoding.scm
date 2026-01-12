
(define encode
    (lambda (xs)
        (xs->encoded-runs xs)))

(define xs->encoded-runs
    (lambda (xs)
        (runs->encoded-runs
            (xs->runs xs))))

(define xs->runs
    (lambda (xs)
        (define xs->runs
            (lambda (runs run xs)
                (cond
                    ((null? xs)
                        (reverse
                            (cons run runs)))
                    ((equal? (car run) (car xs))
                        (xs->runs
                            runs
                            (cons (car xs) run)
                            (cdr xs)))
                    (else
                        (xs->runs
                            (cons run runs)
                            (take xs 1)
                            (drop xs 1))))))
        (cond
            ((null? xs)
                '())
            (else
                (xs->runs
                    '()
                    (take xs 1)
                    (drop xs 1))))))

(define runs->encoded-runs
    (lambda (runs)
        (map run->encoded-run runs)))

(define run->encoded-run
    (lambda (run)
        (cons
            (car run)
            (length run))))

(define decode
    (lambda (encoded-runs)
        (encoded-runs->xs encoded-runs)))

(define encoded-runs->xs
    (lambda (encoded-runs)
        (runs->xs
            (encoded-runs->runs encoded-runs))))

(define encoded-runs->runs
    (lambda (encoded-runs)
        (map encoded-run->run encoded-runs)))

(define encoded-run->run
    (lambda (encoded-run)
        (define encoded-run->run
            (lambda (run x n)
                (cond
                    ((= n 0)
                        run)
                    (else
                        (encoded-run->run
                            (cons x run)
                            x
                            (- n 1))))))
        (encoded-run->run
            '()
            (car encoded-run)
            (cdr encoded-run))))

(define runs->xs
    (lambda (runs)
        (define runs->xs
            (lambda (xs runs)
                (cond
                    ((null? runs)
                        xs)
                    (else
                        (runs->xs
                            (append xs (car runs))
                            (cdr runs))))))
        (runs->xs '() runs)))

