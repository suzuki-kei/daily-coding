
(define-syntax trace
    (syntax-rules ()
        ((_ expression)
            (begin
                (print "==== " 'expression)
                (print expression)
                (print)))))

(define main
    (lambda (arguments)
        (let ((tree '(a (b) (((c d) e) f) (g))))
            (trace tree)
            (trace (tree-walk for-each print tree atom?))
            (trace (tree-walk (reversed for-each) print tree atom?))
            (trace (tree-walk map identity tree atom?))
            (trace (tree-walk (reversed map) identity tree atom?)))
        0))

(define tree-walk
    (lambda (walker procedure tree leaf?)
        (walker
            (lambda (x)
                (cond
                    ((leaf? x)
                        (procedure x))
                    (else
                        (tree-walk walker procedure x leaf?))))
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

