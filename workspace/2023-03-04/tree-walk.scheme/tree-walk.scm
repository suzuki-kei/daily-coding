
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
            (trace (tree-walk for-each print atom? tree))
            (trace (tree-walk (reversed for-each) print atom? tree))
            (trace (tree-walk map identity atom? tree))
            (trace (tree-walk (reversed map) identity atom? tree)))
        0))

(define tree-walk
    (lambda (walker process-leaf leaf? tree)
        (walker
            (lambda (node)
                (cond
                    ((leaf? node)
                        (process-leaf node))
                    (else
                        (tree-walk walker process-leaf leaf? node))))
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
        (lambda (procedure tree)
            (walker
                procedure
                (reverse tree)))))

