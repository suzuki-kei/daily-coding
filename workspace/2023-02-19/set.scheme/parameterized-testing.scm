
(define parameterized-test
    (lambda (tuples procedure . optionals)
        (for-each
            (lambda (index tuple)
                (apply
                    test
                    (cons*
                        (format "#~d" (+ index 1))
                        (car tuple)
                        (lambda ()
                            (apply procedure (cdr tuple)))
                        optionals)))
            (iota (length tuples))
            tuples)))

