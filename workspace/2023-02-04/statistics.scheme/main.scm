(use srfi-27)
(load "statistics")

(define-syntax demonstration
    (syntax-rules ()
        ((_ xs)
            (print
                (format
                    "~s = ~a"
                    'xs
                    (map number->inexact xs))))
        ((_ f xs)
            (print
                (format
                    "~s = ~a"
                    'f
                    (number->inexact (f xs)))))))

(define main
    (lambda (arguments)
        (random-source-randomize!
            default-random-source)
        (let ((xs (generate-random-values 10)))
            (demonstration xs)
            (demonstration count xs)
            (demonstration minimum xs)
            (demonstration maximum xs)
            (demonstration sum xs)
            (demonstration product xs)
            (demonstration average xs)
            (demonstration variance xs)
            (demonstration stddev xs))
        0))

(define number->inexact
    (lambda (x)
        (if
            (integer? x)
            x
            (exact->inexact x))))

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (+ 1 (random-integer 10)))
            (iota n))))

