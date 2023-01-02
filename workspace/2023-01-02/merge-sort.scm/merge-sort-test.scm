
(use gauche.test)
(load "merge-sort.scm")

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.merge-sort)
        (test.merge)))

(define test.merge-sort
    (lambda ()
        (test-start "merge-sort")
        (for-each
            (lambda (n)
                (test*
                    (format "#~d" (+ n 1))
                    #t
                    (sorted?
                        (merge-sort
                            (generate-random-values n)))))
            (iota 20))
        (test-end)))

(define test.merge
    (lambda ()
        (test-start "merge")
        (test* "#1" '() (merge '() '()))
        (test* "#2" '(1) (merge '() '(1)))
        (test* "#3" '(1) (merge '(1) '()))
        (test* "#4" '(1 2) (merge '() '(1 2)))
        (test* "#5" '(1 2) (merge '(1) '(2)))
        (test* "#6" '(1 2) (merge '(1 2) '()))
        (test-end)))

