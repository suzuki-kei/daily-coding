
(define count
    (lambda (xs)
        (fold
            (lambda (x count)
                (+ count 1))
            0
            xs)))

(define sum
    (lambda (xs)
        (fold + 0 xs)))

(define product
    (lambda (xs)
        (fold * 1 xs)))

(define minimum
    (lambda (xs)
        (fold
            (lambda (x minimum)
                (if (< x minimum) x minimum))
            (car xs)
            (cdr xs))))

(define maximum
    (lambda (xs)
        (fold
            (lambda (x maximum)
                (if (> x maximum) x maximum))
            (car xs)
            (cdr xs))))

(define average
    (lambda (xs)
        (/
            (sum xs)
            (count xs))))

(define variance
    (lambda (xs)
        (/
            (sum
                (map
                    (lambda (x)
                        (square
                            (- x (average xs))))
                    xs))
            (count xs))))

(define stddev
    (lambda (xs)
        (sqrt
            (variance xs))))

