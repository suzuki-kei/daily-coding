(use srfi-151)

(define main
    (lambda (_)
        (print-sierpinski-gasket 32 32)
        0))

(define print-sierpinski-gasket
    (lambda (width height)
        (define print-rows
            (lambda (y)
                (cond
                    ((< y height)
                        (print-row y 0)
                        (print-rows (+ y 1))))))
        (define print-row
            (lambda (y x)
                (cond
                    ((< x width)
                        (print-cell y x)
                        (print-row y (+ x 1)))
                    (else
                        (display "\n")))))
        (define print-cell
            (lambda (y x)
                (cond
                    ((= (bitwise-and y x) 0)
                        (display "＊"))
                    (else
                        (display "　")))))
    (print-rows 0)))

