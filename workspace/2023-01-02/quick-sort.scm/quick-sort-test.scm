
(use gauche.test)
(load "quick-sort.scm")

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.quick-sort)
        (test.partition)))

(define test.quick-sort
    (lambda ()
        (define xss
            (append
                '(
                    ()
                    (1)
                    (1 2)
                    (2 1)
                    (1 2 3)
                    (1 3 2)
                    (2 1 3)
                    (2 3 1)
                    (3 1 2)
                    (3 2 1))
                (map
                    generate-random-values
                    '(0 1 2 3 10 100 1000))))
        (test-start "quick-sort")
        (for-each
            (lambda (index xs)
                (test*
                    (format "#~d" (+ index 1))
                    #t
                    (sorted? (quick-sort xs))))
            (iota (length xss))
            xss)
        (test-end)))

(define test.partition
    (lambda ()
        (define tuples '(
            ; (pivot xs)
            (5 ())
            (1 (1 1 1))
            (5 (1 2 3 4 5 6 7 8 9))))

        (test-start "partition")
        (for-each
            (lambda (index pivot xs)
                (receive
                    (less-xs equal-xs greater-xs)
                    (partition 0 '())
                    (test*
                        (format "#~d" (+ index 1))
                        #t
                        (and
                            (every (lambda (x) (< x 0)) less-xs)
                            (every (lambda (x) (= x 0)) equal-xs)
                            (every (lambda (x) (> x 0)) greater-xs)))))
            (iota (length tuples))
            (map car tuples)
            (map cadr tuples))
        (test-end)))

