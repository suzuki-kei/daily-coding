(use srfi-27)

(define-syntax trace
    (syntax-rules ()
        ((_ expression)
            (print 'expression " = " expression))))

(define main
    (lambda (arguments)
        (random-source-randomize!
            default-random-source)
        (let ((xs (generate-random-values 10)))
            (trace xs)
            (trace (count xs))
            (trace (sum xs))
            (trace (product xs))
            (trace (minimum xs))
            (trace (maximum xs))
            (trace (average xs))
            (trace (variance xs))
            (trace (stddev xs))
            (trace (map factorial (iota 10 1))))
        0))

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (+ (random-integer 20) 1))
            (iota n))))

(define count
    (lambda (xs)
        (fold
            (lambda (x count)
                (+ count 1))
            0
            xs)))

(define sum
    (lambda (xs)
        (fold
            (lambda (x sum)
                (+ sum x))
            0
            xs)))

(define product
    (lambda (xs)
        (fold
            (lambda (x product)
                (* product x))
            1
            xs)))

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

(define factorial
    (lambda (n)
        (cond
            ((< n 0)
                (error (format "n must be nonnegative: n=~d" n)))
            (else
                (product
                    (iota n 1))))))

