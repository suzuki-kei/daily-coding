
(define encode
    (lambda (xs)
        (xs->encoded-runs xs)))

(define xs->encoded-runs
    (lambda (xs)
        (runs->encoded-runs
            (xs->runs xs))))

(define xs->runs
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            (else
                (xs->runs.recursive
                    '()
                    (take xs 1)
                    (drop xs 1))))))

(define xs->runs.recursive
    (lambda (runs run xs)
        (cond
            ((null? xs)
                (reverse
                    (cons run runs)))
            ((equal? (car xs) (car run))
                (xs->runs.recursive
                    runs
                    (cons (car xs) run)
                    (cdr xs)))
            (else
                (xs->runs.recursive
                    (cons run runs)
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
        (encoded-run->run.recursive
            '()
            (car encoded-run)
            (cdr encoded-run))))

(define encoded-run->run.recursive
    (lambda (run x n)
        (cond
            ((= n 0)
                run)
            (else
                (encoded-run->run.recursive
                    (cons x run)
                    x
                    (- n 1))))))

(define runs->xs
    (lambda (runs)
        (runs->xs.recursive
            '() runs)))

(define runs->xs.recursive
    (lambda (xs runs)
        (cond
            ((null? runs)
                xs)
            (else
                (runs->xs.recursive
                    (append xs (car runs))
                    (cdr runs))))))

