(use srfi-13)
(use srfi-151)

(define main
    (lambda (_)
        (print
            (sierpinski-gasket 32 32))
        0))

(define sierpinski-gasket
    (lambda (width height)
        (sierpinski-gasket-rows height width)))

(define sierpinski-gasket-rows
    (lambda (height width)
        (string-join
            (map
                (lambda (y)
                    (sierpinski-gasket-row width y))
                (iota height))
            "\n")))

(define sierpinski-gasket-row
    (lambda (width y)
        (string-join
            (map
                (lambda (x)
                    (sierpinski-gasket-cell x y))
                (iota width))
            " ")))

(define sierpinski-gasket-cell
    (lambda (x y)
        (cond
            ((= (bitwise-and x y) 0)
                "*")
            (else
                " "))))

