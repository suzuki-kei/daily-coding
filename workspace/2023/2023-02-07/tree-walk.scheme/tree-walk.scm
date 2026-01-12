
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

(define tree
    '((a) b ((c d) e)))

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
        (lambda (f xs)
            (walker f (reverse xs)))))

(print "==== for-each print")
(tree-walk for-each print tree atom?)

(print "==== (reversed for-each) print")
(tree-walk (reversed for-each) print tree atom?)

(print "==== map identity")
(print (tree-walk map identity tree atom?))

(print "==== (reversed map) identity")
(print (tree-walk (reversed map) identity tree atom?))

