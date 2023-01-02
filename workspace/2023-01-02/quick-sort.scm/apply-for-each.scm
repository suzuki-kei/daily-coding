
;
; (apply-for-each callback (xs1 xs2 ...))
;     => (for-each callback xs1 xs2 ...)
;
(define apply-for-each
    (lambda (callback tuples)
        (for-each
            (lambda (tuple)
                (apply callback tuple))
            tuples)))

