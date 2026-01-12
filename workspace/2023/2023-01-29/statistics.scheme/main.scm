(use srfi-27)
(load "statistics")

(define main
    (lambda (arguments)
        (random-source-randomize!
            default-random-source)
        (let ((xs (generate-random-values 10)))
            (print (format "xs = ~a" xs))
            (print (format "count = ~a" (count xs)))
            (print (format "sum = ~a" (sum xs)))
            (print (format "average = ~a" (average xs)))
            (print (format "minimum = ~a" (minimum xs)))
            (print (format "maximum = ~a" (maximum xs)))
            (print (format "variance = ~a" (variance xs)))
            (print (format "stddev = ~a" (stddev xs)))
            0)))

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (+ (random-integer 90) 10))
            (iota n))))

