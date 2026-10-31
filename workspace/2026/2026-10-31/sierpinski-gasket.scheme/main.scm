(import (scheme base))
(import (scheme write))
(import (srfi 1))
(import (srfi 13))
(import (srfi 151))

(define main
    (lambda ()
        (print (sierpinski-gasket 32 32))
        0))

(define sierpinski-gasket
    (lambda (width height)
        (sierpinski-gasket-rows width height)))

(define sierpinski-gasket-rows
    (lambda (width height)
        (string-concatenate
            (intersperse
                "\n"
                (map
                    (lambda (y)
                        (sierpinski-gasket-row width y))
                    (iota height))))))

(define sierpinski-gasket-row
    (lambda (width y)
        (list->string
            (intersperse
                #\ 
                (map
                    (lambda (x)
                        (sierpinski-gasket-cell x y))
                    (iota width))))))

(define sierpinski-gasket-cell
    (lambda (x y)
        (cond
            ((= (bitwise-and x y) 0)
                #\*)
            (else
                #\ ))))

(define intersperse
    (lambda (separator xs)
        (define accumulate
            (lambda (separator xs interspersed)
                (cond
                    ((null? xs)
                        (cdr
                            (reverse interspersed)))
                    (else
                        (accumulate
                            separator
                            (cdr xs)
                            (cons* (car xs) separator interspersed))))))
        (accumulate separator xs '())))

(define print
    (lambda (string)
        (display string)
        (newline)))

(main)

