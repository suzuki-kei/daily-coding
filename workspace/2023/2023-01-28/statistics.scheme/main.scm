(load "statistics")

(define main
    (lambda (arguments)
        (let ((xs (iota 10 1)))
            (print (format "xs = ~a" xs))
            (print (format "sum = ~d" (sum xs)))
            (print (format "maximum = ~d" (maximum xs)))
            (print (format "minimum = ~d" (minimum xs)))
            (print (format "average = ~d" (average xs)))
            (print (format "median = ~d" (median xs))))
        0))

