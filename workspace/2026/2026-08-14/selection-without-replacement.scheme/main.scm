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
            (lambda (value state)
                (let ((xs (car state))
                      (n-selected (cdr state)))
                    (cond
                        ((should-select? value n-selected)
                            (cons
                                (cons value xs)
                                (+ n-selected 1)))
                        (else
                            state)))))
        (define should-select?
            (lambda (value n-selected)
                (let ((numerator (- n n-selected))
                      (denominator (+ (- max value) 1)))
                    (<
                        (random-real)
                        (/ numerator denominator)))))
        (reverse
            (car
                (fold
                    folder
                    (cons '() 0)
                    (range min max))))))

(define range
    (lambda (min max)
        (iota
            (+ (- max min) 1)
            min)))

