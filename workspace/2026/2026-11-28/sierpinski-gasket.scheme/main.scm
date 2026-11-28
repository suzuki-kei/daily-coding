(import
    (scheme base)
    (scheme process-context)
    (scheme write)
    (srfi 1)
    (srfi 13)
    (srfi 151)
)

(define main
    (lambda ()
        (display
            (sierpinski-gasket 32 32))
        (newline)
        0))

(define sierpinski-gasket
    (lambda (width height)
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

(exit
    (main))

