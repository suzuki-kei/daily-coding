
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
            (trace (tree-walk for-each print tree atom?))
            (trace (tree-walk (reversed for-each) print tree atom?))
            (trace (tree-walk map identity tree atom?))
            (trace (tree-walk (reversed map) identity tree atom?)))
        0))

(define tree-walk
    (lambda (walker f tree leaf?)
        (walker
            (lambda (x)
                (cond
                    ((leaf? x)
                        (f x))
                    (else
                        (tree-walk walker f x leaf?))))
            tree)))

(define atom?
    (lambda (x)
        (and
            (not (null? x))
            (not (pair? x)))))

(define identity
    (lambda (x)
        x))

(define reversed
    (lambda (walker)
        (lambda (f tree)
            (walker
                f
                (reverse tree)))))

