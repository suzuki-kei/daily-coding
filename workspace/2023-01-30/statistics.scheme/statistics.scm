
(define count
    (lambda (xs)
        (fold
            (lambda (x count) (+ count 1))
            0
            xs)))

(define sum
    (lambda (xs)
        (fold + 0 xs)))

(define product
    (lambda (xs)
        (fold * 1 xs)))

(define average
    (lambda (xs)
        (/ (sum xs) (count xs))))

(define square
    (lambda (x)
        (* x x)))

(define variance
    (lambda (xs)
        (/
            (sum
                (map
                    (lambda (x) (square (- x (average xs))))
                    xs))
            (count xs))))

(define stddev
    (lambda (xs)
        (sqrt (variance xs))))

