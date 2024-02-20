
(define main
    (lambda (_)
        (describe-deviation-values
            '(96 70 59 54 49 41 38 36 33 24))
        (describe-correlation-coefficient
            '(40 60 70 80 100)
            '(50 60 30 70 90))
        0))

(define describe-deviation-values
    (lambda (xs)
        (define print-deviation-value
            (lambda (x xs)
                (print
                    (format
                        "点数 = ~a, 偏差値 = ~a"
                        x
                        (deviation-value x xs)))))
        (print "==== 偏差値")
        (for-each
            (lambda (x)
                (print-deviation-value x xs))
            xs)))

(define describe-correlation-coefficient
    (lambda (xs ys)
        (print "==== 相関係数")
        (print
            (correlation-coefficient xs ys))))

(define sum
    (lambda (xs)
        (reduce + 0 xs)))

(define mean
    (lambda (xs)
        (/
            (sum xs)
            (length xs)
            1.0)))

(define variance
    (lambda (xs)
        (define sum-of-power-of-difference
            (lambda (xs mean)
                (sum
                    (map
                        (lambda (x)
                            (expt
                                (- x mean)
                                2))
                        xs))))
        (/
            (sum-of-power-of-difference
                xs
                (mean xs))
            (length xs))))

(define stddev
    (lambda (xs)
        (sqrt
            (variance xs))))

(define deviation-value
    (lambda (x xs)
        (+
            (*
                (/
                    (- x (mean xs))
                    (stddev xs))
                10)
            50)))

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

(define correlation-coefficient
    (lambda (xs ys)
        (/
            (covariance xs ys)
            (*
                (stddev xs)
                (stddev ys)))))

