
(define parameterized.test*
    (lambda (tuples procedure . optionals)
        (parameterized.test*.tailrec
            tuples 0 procedure optionals)))

(define parameterized.test*.tailrec
    (lambda (tuples index procedure optionals)
        (cond
            ((null? tuples)
                #f)
            (else
                (let* ((name (format "#~d" (+ index 1)))
                       (expected (caar tuples))
                       (arguments (cdar tuples))
                       (thunk (lambda () (apply procedure arguments))))
                    (apply
                        test
                        (cons* name expected thunk optionals)))
                (parameterized.test*.tailrec
                    (cdr tuples)
                    (+ index 1)
                    procedure
                    optionals)))))

