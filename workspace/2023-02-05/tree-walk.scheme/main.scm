
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

(define tree
    '(a (b c) (((d) e) f) g))

(define leaf?
    (lambda (x) (not (list? x))))

(define identity
    (lambda (x)
        x))

(define reversed
    (lambda (walker)
        (lambda (procedure xs)
            (walker
                procedure
                (reverse xs)))))

(print "==== tree")
(print tree)

(print "==== for-each print")
(tree-walk for-each print tree leaf?)

(print "==== (reversed for-each) print")
(tree-walk (reversed for-each) print tree leaf?)

(print "==== map identity")
(print (tree-walk map identity tree leaf?))

(print "==== (reversed map) identity")
(print (tree-walk (reversed map) identity tree leaf?))

