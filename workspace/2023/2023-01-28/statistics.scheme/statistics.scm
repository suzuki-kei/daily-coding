
(define sum
    (lambda (xs)
        (fold
            +
            (car xs)
            (cdr xs))))

(define minimum
    (lambda (xs)
        (fold
            (lambda (x1 x2)
                (if (< x1 x2) x1 x2))
            (car xs)
            (cdr xs))))

(define maximum
    (lambda (xs)
        (fold
            (lambda (x1 x2)
                (if (> x1 x2) x1 x2))
            (car xs)
            (cdr xs))))

(define average
    (lambda (xs)
        (exact->inexact
            (/
                (sum xs)
                (length xs)))))

(define median
    (lambda (xs)
        (let* ((n (length xs))
               (sorted (sort xs))
               (reversed (reverse sorted))
               (median1 (last (take sorted (round (/ n 2)))))
               (median2 (last (take reversed (round (/ n 2))))))
            (exact->inexact (/ (+ median1 median2) 2)))))

