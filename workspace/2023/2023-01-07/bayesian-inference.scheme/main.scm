(load "bayesian-inference.scm")

(define main
    (lambda (arguments)
        (define honest-probabilities
            '(0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0))
        (define say-flags-list '(
            (#f)
            (#f #f)
            (#f #f #f)
            (#t)
            (#t #t)
            (#t #t #t)))
        (for-each
            (lambda (honest-probability say-flags)
                (let* ((person (person.new honest-probability)))
                    (print
                        (format
                            "~a, say-flags=~,2f, ~a"
                            (person.format person)
                            say-flags
                            (person.format (simulate person say-flags))))))
            honest-probabilities
            say-flags-list)
        0))

