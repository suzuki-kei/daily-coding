
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

