(use gauche.test)

(define-syntax define-parameterized-test
    (syntax-rules ()
        ((_ test-procedure-name test-section-name expected-expression-pairs . optionals)
            (define test-procedure-name
                (lambda ()
                    (test-section test-section-name)
                    (parameterized-test* expected-expression-pairs . optionals))))))

(define parameterized-test*
    (lambda (expected-expression-pairs . optionals)
        (for-each
            (lambda (index expected-expression-pair)
                (apply
                    test
                    (cons*
                        (format "#~d" index)
                        (car expected-expression-pair)
                        (lambda () (eval (cadr expected-expression-pair) interaction-environment))
                        optionals)))
            (iota (length expected-expression-pairs) 1)
            expected-expression-pairs)))

