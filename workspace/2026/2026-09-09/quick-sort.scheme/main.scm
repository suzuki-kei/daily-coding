(use srfi-13)
(use srfi-27)

(define main
    (lambda (_)
        (initialize)
        (demonstration)
        0))

(define initialize
    (lambda ()
        (random-source-randomize! default-random-source)))

(define demonstration
    (lambda ()
        (let ((xs (generate-random-values 10 99 20)))
            (print-xs xs)
            (print-xs (quick-sort xs)))))

(define generate-random-values
    (lambda (min max n)
        (map
            (lambda (_)
                (random-range min max))
            (iota n))))

(define random-range
    (lambda (min max)
        (+
            (random-integer
                (+ (- max min) 1))
            min)))

(define print-xs
    (lambda (xs)
        (display
            (format
                "~a (~a)~%"
                (xs->string " " xs)
                (xs->sorted-label xs)))))

(define xs->string
    (lambda (separator xs)
        (string-concatenate
            (map
                x->string
                (intersperse separator xs)))))

(define xs->sorted-label
    (lambda (xs)
        (cond
            ((sorted? xs)
                "sorted")
            (else
                "not sorted"))))

(define sorted?
    (lambda (xs)
        (cond
            ((null? xs)
                #t)
            ((null? (cdr xs))
                #t)
            ((> (car xs) (cadr xs))
                #f)
            (else
                (sorted? (cdr xs))))))

(define quick-sort
    (lambda (xs)
        (cond
            ((null? xs)
                '())
            (else
                (receive
                    (less-xs equal-xs greater-xs)
                    (partition-3way (car xs) xs)
                    (append
                        (quick-sort less-xs)
                        equal-xs
                        (quick-sort greater-xs)))))))

(define partition-3way
    (lambda (pivot xs)
        (define folder
            (lambda (x xss)
                (let ((less-xs (car xss))
                      (equal-xs (cadr xss))
                      (greater-xs (caddr xss)))
                    (cond
                        ((< x pivot)
                            (list
                                (cons x less-xs)
                                equal-xs
                                greater-xs))
                        ((> x pivot)
                            (list
                                less-xs
                                equal-xs
                                (cons x greater-xs)))
                        (else
                            (list
                                less-xs
                                (cons x equal-xs)
                                greater-xs))))))
        (let ((xss (fold folder '(() () ()) xs)))
            (values
                (car xss)
                (cadr xss)
                (caddr xss)))))

