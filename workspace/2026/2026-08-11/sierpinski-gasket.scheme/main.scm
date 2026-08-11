(use srfi-13)
(use srfi-151)

(define main
    (lambda (_)
        (display (sierpinski-gasket 32 32))
        (newline)
        0))

(define sierpinski-gasket
    (lambda (width height)
        (define rows
            (lambda (height width)
                (string-concatenate
                    (intersperse
                        "\n"
                        (map
                            (lambda (y)
                                (row y width))
                            (iota height))))))
        (define row
            (lambda (y width)
                (list->string
                    (map
                        (lambda (x)
                            (cell y x))
                        (iota width)))))
        (define cell
            (lambda (y x)
                (cond
                    ((= (bitwise-and y x) 0)
                        #\＊)
                    (else
                        #\　))))
        (rows height width)))

