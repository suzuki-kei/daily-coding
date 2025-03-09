(use srfi-27)

(define main
    (lambda (_)
        (for-each
            print
            (generate-random-values 20))
        0))

(define initialize
    (lambda ()
        (random-source-randomize! default-random-source)))

(define generate-random-values
    (lambda (n)
        (map
            (lambda (_)
                (+
                    (random-integer 90)
                    10))
            (iota 10))))

