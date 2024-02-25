
(define main
    (lambda (_)
        (print-deviation-scores
            '(96 70 59 54 49 41 38 36 33 24))
        (print-correlation-coefficient
            '(40 60 70 80 100)
            '(50 60 30 70 90))
        (print-feet->meter
            30000)
        0))

(define print-deviation-scores
    (lambda (xs)
        (print "==== 偏差値")
        (print "xs = " xs)
        (for-each
            (lambda (score deviation-score)
                (print
                    (format "score=~a, deviation-score=~a" score deviation-score)))
            xs
            (deviation-scores xs))))

(define print-correlation-coefficient
    (lambda (xs ys)
        (print "==== 相関係数")
        (print "xs = " xs)
        (print "ys = " ys)
        (print
            "correlation-coefficient = "
            (correlation-coefficient xs ys))))

(define print-feet->meter
    (lambda (feet)
        (print "==== フィート -> メートル")
        (print
            (format
                "~a feet = ~a meter"
                feet
                (feet->meter feet)))))

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

; 不偏分散
(define unbiased-variance
    (lambda (xs)
        (/
            (sum-of-squared-deviation
                xs
                (mean xs))
            (-
                (length xs)
                1))))

; 標準偏差
(define stddev
    (lambda (xs)
        (sqrt
            (variance xs))))

; 不偏標準偏差
(define unbiased-stddev
    (lambda (xs)
        (sqrt
            (unbiased-variance xs))))

; 偏差値
(define deviation-score
    (lambda (x mean stddev)
        (+
            (*
                (/
                    (- x mean)
                    stddev)
                10)
            50)))

(define deviation-scores
    (lambda (xs)
        (let ((mean (mean xs))
              (stddev (stddev xs)))
            (map
                (lambda (x)
                    (deviation-score x mean stddev))
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

; フィート -> メートル
(define feet->meter
    (lambda (feet)
        (* feet 0.3048)))

