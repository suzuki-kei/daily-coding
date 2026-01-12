;
; Run-Length Encoding.
;
; Words
; =====
; xs
;     値のリスト.
;     Ex. '(a a b c c c)
; run
;     同じ値からなるリスト.
;     Ex. '(a a)
; runs
;     run のリスト.
;     Ex. '((a a) (b) (c c c))
; encoded-run
;     エンコードした run.
;     Ex. '(a . 2)
; encoded-runs
;     encoded-run からなるリスト.
;     Ex. '((a . 2) (b . 1) (c . 3))
;

;
; エンコードする.
;
(define encode
    (lambda (xs)
        (xs->encoded-runs xs)))

;
; xs を encoded-runs に変換する.
; (Ex. '(a a b c c c) => '((a . 2) (b . 1) (c . 3)))
;
(define xs->encoded-runs
    (lambda (xs)
        (map
            run->encoded-run
            (xs->runs xs))))

;
; run を encoded-run に変換する.
; (Ex. '(a a) => '(a . 2))
;
(define run->encoded-run
    (lambda (run)
        (cond
            ((null? run)
                '(#f . 0))
            (else
                (cons
                    (car run)
                    (length run))))))

;
; xs を runs に変換する.
; (Ex. '(a a b c c c) => '((a a) (b) (c c c)))
;
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

;
; デコードする.
;
(define decode
    (lambda (encoded-runs)
        (encoded-runs->xs encoded-runs)))

;
; encoded-runs を xs に変換する.
; (Ex. '((a . 2) (b . 1) (c . 3)) => '(a a b c c c))
;
(define encoded-runs->xs
    (lambda (encoded-runs)
        (runs->xs
            (map
                encoded-run->run
                encoded-runs))))

;
; encoded-run を run に変換する.
; (Ex. '(a . 2) => '(a a))
;
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

;
; runs を xs に変換する.
; (Ex. '((a a) (b) (c c c)) => '(a a b c c c))
;
(define runs->xs
    (lambda (runs)
        (fold-right append '() runs)))

