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
        (define sizes
            '(0 1 2 3 10 100 1000))
        (test-start "merge-sort")
        (for-each
            (lambda (index size)
                (test*
                    (format "#~d" (+ index 1))
                    #t
                    (sorted?
                        (merge-sort
                            (generate-random-values size)))))
            (iota (length sizes) 1)
            sizes)
        (test-end)))

(define test.merge
    (lambda ()
        (test-start "merge")
        (test* "#1" '() (merge '() '()))
        (test* "#2" '(1) (merge '(1) '()))
        (test* "#3" '(1) (merge '() '(1)))
        (test* "#4" '(1 1) (merge '(1) '(1)))
        (test* "#5" '(1 2) (merge '(1 2) '()))
        (test* "#6" '(1 2) (merge '(1) '(2)))
        (test* "#7" '(1 2) (merge '() '(1 2)))
        (test-end)))

