(use srfi-27)
(load "statistics")

(define-syntax demonstration
    (syntax-rules ()
        ((_ xs)
            (print
                (format
                    "~s = ~a"
                    'xs
                    (map noninteger->inexact xs))))
        ((_ procedure xs)
            (print
                (format
                    "~s = ~a"
                    'procedure
                    (noninteger->inexact (procedure xs)))))))

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

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (+ (random-integer 10) 1))
            (iota n))))

(define noninteger->inexact
    (lambda (x)
        (cond
            ((integer? x)
                x)
            (else
                (exact->inexact x)))))

