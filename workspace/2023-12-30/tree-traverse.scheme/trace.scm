
(define-syntax trace
    (syntax-rules ()
        ((_ x)
            (begin
                (print "==== " 'x)
                (print x)))))

