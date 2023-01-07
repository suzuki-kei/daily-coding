(use gauche.test)
(load "bayesian-inference.scm")

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.constants)
        (test.assoc-value)
        (test.person.new)))

(define test.constants
    (lambda ()
        (test-start "sum of probability must be 1.0.")
        (test* "#1" 1.0 (+ liar-say-lie-probability liar-say-truth-probability))
        (test* "#2" 1.0 (+ honest-say-lie-probability honest-say-truth-probability))
        (test-end)))

(define test.assoc-value
    (lambda ()
        (define alist '(
            (one . 1)
            (two . 2)
            (three . 3)))
        (test-start "assoc-value")
        (test* "#1" 1 (assoc-value 'one alist))
        (test* "#2" 2 (assoc-value 'two alist))
        (test* "#3" 3 (assoc-value 'three alist))
        (test-end)))

(define test.person.new
    (lambda ()
        (define honest-probabilities
            '(0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0))
        (test-start "person.new")
        (for-each
            (lambda (index honest-probability)
                (let* ((person (person.new honest-probability)))
                    (test*
                        (format "#~d" (+ index 1))
                        #t
                        (approx=?
                            1.0
                            (+ (person.liar-probability person)
                               (person.honest-probability person))))))
            (iota (length honest-probabilities))
            honest-probabilities)
        (test-end)))

