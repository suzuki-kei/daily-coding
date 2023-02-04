
(define count
    (lambda (xs)
        (fold
            (lambda (x count)
                (+ count 1))
            0
            xs)))

(define less
    (lambda (x1 x2)
        (if
            (< x1 x2)
            x1
            x2)))

(define greater
    (lambda (x1 x2)
        (if
            (> x1 x2)
            x1
            x2)))

(define minimum
    (lambda (xs)
        (fold
            less
            (car xs)
            (cdr xs))))

(define maximum
    (lambda (xs)
        (fold
            greater
            (car xs)
            (cdr xs))))

(define sum
    (lambda (xs)
        (fold
            +
            0
            xs)))

(define product
    (lambda (xs)
        (fold
            *
            1
            xs)))

(define average
    (lambda (xs)
        (/
            (sum xs)
            (count xs))))

(define variance
    (lambda (xs)
        (let*
            ((count
                (count xs))
             (average
                (average xs))
             (square-of-difference
                (lambda (x) (square (- x average))))
             (square-of-differences
                (map square-of-difference xs))
             (sum-of-square-of-difference
                (sum square-of-differences)))
            (/ sum-of-square-of-difference count))))

(define stddev
    (lambda (xs)
        (sqrt
            (variance xs))))

