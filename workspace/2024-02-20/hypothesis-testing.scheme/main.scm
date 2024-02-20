
(define main
    (lambda (_)
        (demonstration
            '(142 132 127 140 142 130 126)
            '(145 130 150 142 145 155 148))
        (demonstration
            '(148 138 133 146 148 136 132)
            '(145 130 150 142 145 155 148))
        0))

(define demonstration
    (lambda (xs ys)
        (print "================================================================================")
        (print "xs = " xs)
        (print "ys = " ys)
        (print "mean(xs) = " (mean xs))
        (print "mean(ys) = " (mean ys))
        (print "unbiased-stddev(xs, ys) = " (two-sample-unbiased-stddev xs ys))
        (print "t-value(xs, ys) = " (t-value xs ys))))

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

; 不偏分散
(define unbiased-variance
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
        (let* ((n (length xs))
               (mean (mean xs))
               (sum-of-power-of-difference (sum-of-power-of-difference xs mean)))
            (/
                sum-of-power-of-difference
                (- n 1)))))

; 不偏標準偏差
(define unbiased-stddev
    (lambda (xs)
        (sqrt
            (unbiased-variance xs))))

; 二標本普遍分散
(define two-sample-unbiased-variance
    (lambda (xs ys)
        (/
            (+
                (*
                    (- (length xs) 1)
                    (unbiased-variance xs))
                (*
                    (- (length ys) 1)
                    (unbiased-variance ys)))
            (+
                (length xs)
                (length ys)
                -2))))

; 二標本不偏標準偏差
(define two-sample-unbiased-stddev
    (lambda (xs ys)
        (sqrt
            (two-sample-unbiased-variance xs ys))))

; t 値 (t-value)
(define t-value
    (lambda (xs ys)
        (/
            (-
                (mean xs)
                (mean ys))
            (*
                (sqrt
                    (+
                        (/ 1 (length xs))
                        (/ 1 (length ys))))
                (two-sample-unbiased-stddev xs ys)))))

