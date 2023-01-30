
(define count
    (lambda (xs)
        (fold
            (lambda (x count)
                (+ count 1))
            0
            xs)))

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

(define sum
    (lambda (xs)
        (fold + 0 xs)))

(define product
    (lambda (xs)
        (fold * 1 xs)))

(define average
    (lambda (xs)
        (exact->inexact
            (/ (sum xs) (count xs)))))

(define square
    (lambda (x)
        (* x x)))

(define variance
    (lambda (xs)
        (let* ((count
                    (count xs))
               (average
                    (average xs))
               (square-of-differences
                    (map (lambda (x) (square (- x average))) xs))
               (sum-of-square-of-difference
                    (sum square-of-differences)))
            (/ sum-of-square-of-difference count))))

(define stddev
    (lambda (xs)
        (sqrt (variance xs))))

