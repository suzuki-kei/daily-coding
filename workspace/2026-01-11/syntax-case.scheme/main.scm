(require srfi/64)

(define-syntax my-test
    (lambda (syntax-object)
        (syntax-case syntax-object ()
            ((_ test-case f)
                #'(test-case
                    (symbol->string (syntax-e #'f))
                    f)))))

(define factorial.non-tailrec
    (lambda (n)
        (define factorial
            (lambda (n)
                (cond
                    ((< n 1)
                        1)
                    (else
                        (*
                            n
                            (factorial (- n 1)))))))
        (factorial n)))

(define factorial.tailrec
    (lambda (n)
        (define factorial
            (lambda (n fm)
                (cond
                    ((< n 1)
                        fm)
                    (else
                        (factorial
                            (- n 1)
                            (* n fm))))))
        (factorial n 1)))

(define main
    (lambda ()
        (my-test test-factorial factorial.tailrec)
        (my-test test-factorial factorial.non-tailrec)))

(define test-factorial
    (lambda (name factorial)
        (test-begin name)
        (test-equal "#1" 1 (factorial 0))
        (test-equal "#2" 1 (factorial 1))
        (test-equal "#3" 2 (factorial 2))
        (test-equal "#4" 6 (factorial 3))
        (test-equal "#5" 24 (factorial 4))
        (test-equal "#6" 120 (factorial 5))
        (test-end name)))

(main)

