
(define-syntax trace
    (syntax-rules ()
        ((_ x)
            (begin
                (print "==== " 'x)
                (print x)))))

(define main
    (lambda (_)
        (trace
            (print-permutations 6))
        (trace
            (print-combinations 6))
        (trace
            (print-deviation-scores
                '(96 70 59 54 49 41 38 36 33 24)))
        (trace
            (print-correlation-coefficient
                '(40 60 70 80 100)
                '(50 60 30 70 90)))
        0))

(define print-permutations
    (lambda (max-n)
        (for-each
            (lambda (n)
                (for-each
                    (lambda (r)
                        (print-permutation n r))
                    (iota (+ n 1))))
            (iota (+ max-n 1)))))

(define print-permutation
    (lambda (n r)
        (let ((p (permutation n r)))
            (print
                (format "P(n=~d, r=~d) = ~d" n r p)))))

(define print-combinations
    (lambda (max-n)
        (for-each
            (lambda (n)
                (for-each
                    (lambda (r)
                        (print-combination n r))
                    (iota (+ n 1))))
            (iota (+ max-n 1)))))

(define print-combination
    (lambda (n r)
        (let ((c (combination n r)))
            (print
                (format "C(n=~d, r=~d) = ~d" n r c)))))

(define print-deviation-scores
    (lambda (xs)
        (for-each
            (lambda (score deviation-score)
                (print
                    (format "score=~d, deviation-score=~d" score deviation-score)))
            xs
            (deviation-scores xs))))

(define print-correlation-coefficient
    (lambda (xs ys)
        (print
            (correlation-coefficient xs ys))))

;
; 順列
;
; P(n, r) = n * (n-1) * ... * (n-r+1)
;
(define permutation
    (lambda (n r)
        (permutation.tailrec n r 1)))

(define permutation.tailrec
    (lambda (n r accumulated)
        (cond
            ((= r 0)
                accumulated)
            (else
                (permutation.tailrec
                    (- n 1)
                    (- r 1)
                    (* accumulated n))))))

;
; 組み合わせ
;
; C(n, r)   = n! / (r! * (n-r)!)
; C(n, r-1) = n! / ((r-1)! * (n-(r-1))!)
; r!        = r * (r-1)!
; (n-r)!    = (n-(r-1))! / (n-(r-1))
; C(n, r)   = C(n, r-1) * (n-(r-1)) / r
;
(define combination
    (lambda (n r)
        (cond
            ((or (= n 0) (= r 0) (= n r))
                1)
            (else
                (/
                    (*
                        (combination
                            n
                            (- r 1))
                        (-
                            n
                            (- r 1)))
                    r)))))

; 合計
(define sum
    (lambda (xs)
        (reduce + 0 xs)))

; 平均
(define mean
    (lambda (xs)
        (/
            (sum xs)
            (length xs)
            1.0)))

; 偏差平方和
(define sum-of-squared-deviation
    (lambda (xs base)
        (sum
            (map
                (lambda (x)
                    (expt
                        (- x base)
                        2))
                xs))))

; 分散
(define variance
    (lambda (xs)
        (/
            (sum-of-squared-deviation
                xs
                (mean xs))
            (length xs))))

; 標準偏差
(define stddev
    (lambda (xs)
        (sqrt
            (variance xs))))

; 偏差値
(define deviation-score
    (lambda (x mean-xs stddev-xs)
        (+
            (*
                (/
                    (- x mean-xs)
                    stddev-xs)
                10)
            50)))

(define deviation-scores
    (lambda (xs)
        (let ((mean-xs (mean xs))
              (stddev-xs (stddev xs)))
            (map
                (lambda (x)
                    (deviation-score x mean-xs stddev-xs))
                xs))))

; 共分散
(define covariance
    (lambda (xs ys)
        (let ((mean-xs (mean xs))
              (mean-ys (mean ys)))
            (mean
                (map
                    (lambda (x y)
                        (*
                            (- x mean-xs)
                            (- y mean-ys)))
                    xs
                    ys)))))

; 相関係数
(define correlation-coefficient
    (lambda (xs ys)
        (/
            (covariance xs ys)
            (*
                (stddev xs)
                (stddev ys)))))

