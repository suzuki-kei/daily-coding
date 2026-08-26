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
        (define folder
            (lambda (x xs)
                (let* ((n-selected (length xs))
                       (n-remaining (- n n-selected))
                       (n-candidates-remaining (+ (- max x) 1))
                       (selection-probability (/ n-remaining n-candidates-remaining))
                       (r (random-real)))
                    (cond
                        ((< r selection-probability)
                            (cons x xs))
                        (else
                            xs)))))
        (reverse
            (fold
                folder
                '()
                (range min max)))))

(define range
    (lambda (min max)
        (iota
            (+ (- max min) 1)
            min)))

