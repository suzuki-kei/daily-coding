
(define encode
    (lambda (xs)
        (xs->encoded-runs xs)))

(define xs->encoded-runs
    (lambda (xs)
        (map
            run->encoded-run
            (xs->runs xs))))

(define run->encoded-run
    (lambda (run)
        (cond
            ((null? run)
                '(#f . 0))
            (else
                (cons
                    (car run)
                    (length run))))))

(define xs->runs
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            (else
                (xs->runs.tailrec
                    '()
                    (list (car xs))
                    (cdr xs))))))

(define xs->runs.tailrec
    (lambda (runs run xs)
        (cond
            ((null? xs)
                (reverse
                    (cons run runs)))
            ((equal? (car run) (car xs))
                (xs->runs.tailrec
                    runs
                    (cons (car xs) run)
                    (cdr xs)))
            (else
                (xs->runs.tailrec
                    (cons run runs)
                    (list (car xs))
                    (cdr xs))))))

(define decode
    (lambda (encoded-runs)
        (encoded-runs->xs encoded-runs)))

(define encoded-runs->xs
    (lambda (encoded-runs)
        (runs->xs
            (map
                encoded-run->run
                encoded-runs))))

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

