
(define main
    (lambda (_)
        0))

; 合計
(define sum
    (lambda (xs)
        (reduce + 0 xs)))

; 相加平均
(define arithmetic-mean
    (lambda (xs)
        (/
            (sum xs)
            (length xs))))

; 標本分散
(define sample-variance
    (lambda (xs)
        (/
            (sum-of-power-of-differences
                xs
                (arithmetic-mean xs))
            (length xs))))

; 普遍分散
(define unbiased-variance
    (lambda (xs)
        (/
            (sum-of-power-of-differences
                xs
                (arithmetic-mean xs))
            (-
                (length xs)
                1))))

; 差分の二乗
(define sum-of-power-of-differences
    (lambda (xs base)
        (define difference
            (lambda (x)
                (- x base)))
        (define power
            (lambda (x)
                (* x x)))
        (define power-of-differences
            (lambda (xs)
                (map
                    (lambda (x)
                        (power (difference x)))
                    xs)))
        (reduce
            +
            0
            (power-of-differences xs))))

; 不偏標準偏差
(define unbiased-standard-deviation
    (lambda (xs)
        (sqrt
            (unbiased-variance xs))))

