
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
                (xs->runs.tailrec
                    (drop xs 1)
                    (take xs 1)
                    '())))))

(define xs->runs.tailrec
    (lambda (xs run runs)
        (cond
            ((null? xs)
                (reverse
                    (cons run runs)))
            ((equal? (car xs) (car run))
                (xs->runs.tailrec
                    (cdr xs)
                    (cons (car xs) run)
                    runs))
            (else
                (xs->runs.tailrec
                    (cdr xs)
                    (take xs 1)
                    (cons run runs))))))

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
        (encoded-run->run.tailrec
            '()
            (car encoded-run)
            (cdr encoded-run))))

(define encoded-run->run.tailrec
    (lambda (run x n)
        (cond
            ((= n 0)
                run)
            (else
                (encoded-run->run.tailrec
                    (cons x run)
                    x
                    (- n 1))))))

(define runs->xs
    (lambda (runs)
        (runs->xs.tailrec '() runs)))

(define runs->xs.tailrec
    (lambda (xs runs)
        (cond
            ((null? runs)
                xs)
            (else
                (runs->xs.tailrec
                    (append xs (car runs))
                    (cdr runs))))))
