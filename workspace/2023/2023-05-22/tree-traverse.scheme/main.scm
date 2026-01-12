(load "traverse")

(define-syntax trace
    (syntax-rules ()
        ((_ expression)
            (begin
                (print "==== " 'expression)
                (print expression)))))

(define main
    (lambda (arguments)
        (let ((tree '(a (b) ((c d) e))))
            (trace tree)
            (trace (traverse for-each print atom? tree))
            (trace (traverse (reversed for-each) print atom? tree))
            (trace (traverse map identity atom? tree))
            (trace (traverse (reversed map) identity atom? tree)))
        0))

