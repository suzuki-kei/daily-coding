(use gauche.test)

(define-syntax define-parameterized-test*
    (syntax-rules ()
        ((_ procedure-name section-name expected-expression-pairs . optionals)
            (define procedure-name
                (lambda ()
                    (parameterized-test* section-name expected-expression-pairs . optionals))))))

(define parameterized-test*
    (lambda (section-name expected-expression-pairs . optionals)
        (test-section section-name)
        (apply
            for-each-test*
            (cons* expected-expression-pairs optionals))))

(define for-each-test*
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

