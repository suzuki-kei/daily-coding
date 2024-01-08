(load "trace")
(load "traverse")

(define main
    (lambda (_)
        (let ((tree '(a (b) ((c d) e))))
            (trace tree)
            (trace (traverse for-each print atom? tree))
            (trace (traverse (reversed for-each) print atom? tree))
            (trace (traverse map identity atom? tree))
            (trace (traverse (reversed map) identity atom? tree)))
        0))
