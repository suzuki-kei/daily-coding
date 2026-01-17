
(define-syntax trace
    (syntax-rules ()
        ((_ x)
            (display (format "~a = ~a~%" 'x x)))))

(define x1 123)
(define x2 "abc")
(define x3 '(a (b) ((c d) e)))

(trace x1)
(trace x2)
(trace x3)

