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
        (print
            (selection-without-replacement 10 99 20))))

(define selection-without-replacement
    (lambda (min max n)
        (define accumulate
            (lambda (x xs)
                (cond
                    ((<= x max)
                        (accumulate
                            (+ x 1)
                            (next-xs x xs)))
                    (else
                        (reverse xs)))))
        (define next-xs
            (lambda (x xs)
                (let ((numerator (- n (length xs)))
                      (denominator (+ (- max x) 1))
                      (r (random-real)))
                    (cond
                        ((< r (/ numerator denominator))
                            (cons x xs))
                        (else
                            xs)))))
        (accumulate min '())))

