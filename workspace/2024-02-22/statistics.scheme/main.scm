
(define main
    (lambda (_)
        (print-summary
            '(40 60 70 80 100))
        (print-deviation-scores
            '(96 70 59 54 49 41 38 36 33 24))
        (print-correlation-coefficient
            '(40 60 70 80 100)
            '(50 60 30 70 90))
        0))

; 基本統計量を表示する
(define print-summary
    (lambda (xs)
        (print "==== 基本統計量")
        (print "xs = " xs)
        (print "sum = " (sum xs))
        (print "mean = " (mean xs))
        (print "variance = " (variance xs))
        (print "stddev = " (stddev xs))))

; 偏差値を表示する
(define print-deviation-scores
    (lambda (xs)
        (print "==== 偏差値")
        (for-each
            (lambda (score deviation-score)
                (print
                    (format "score=~w, deviation-score=~w" score deviation-score)))
            xs
            (deviation-scores xs))))

; 相関係数を表示する
(define print-correlation-coefficient
    (lambda (xs ys)
        (print "==== 相関係数")
        (print "xs = " xs)
        (print "ys = " ys)
        (print (correlation-coefficient xs ys))))

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

; 偏差の平方和
(define sum-of-squared-deviation
    (lambda (xs base)
        (sum
            (map
                (lambda (x)
                    (expt
                        (- x base)
                        2))
                xs))))

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

