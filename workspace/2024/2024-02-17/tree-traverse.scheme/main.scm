
(define main
    (lambda (_)
        (demonstration '(a (b) ((c d) e)))
        (demonstration '((a (b c)) (d) e))
        0))

(define-syntax trace
    (syntax-rules ()
        ((_ x)
            (begin
                (print "==== " 'x)
                (print x)))))

(define demonstration
    (lambda (tree)
        (print "--------------------------------------------------------------------------------")
        (trace tree)
        (trace (traverse for-each print atom? tree))
        (trace (traverse (reversed for-each) print atom? tree))
        (trace (traverse map identity atom? tree))
        (trace (traverse (reversed map) identity atom? tree))
        (newline)))

(define traverse
    (lambda (process-nodes process-leaf leaf? tree)
        (define process-node
            (lambda (node)
                (cond
                    ((leaf? node)
                        (process-leaf node))
                    (else
                        (traverse process-nodes process-leaf leaf? node)))))
        (process-nodes process-node tree)))

(define atom?
    (lambda (x)
        (and
            (not (null? x))
            (not (pair? x)))))

(define identity
    (lambda (x)
        x))

(define reversed
    (lambda (process-nodes)
        (lambda (process-node nodes)
            (process-nodes
                process-node
                (reverse nodes)))))

