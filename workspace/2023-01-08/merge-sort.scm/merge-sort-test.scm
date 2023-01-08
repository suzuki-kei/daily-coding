(use gauche.test)
(load "merge-sort.scm")

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.merge-sort)
        (test.merge-sort-merge)))

(define test.merge-sort
    (lambda ()
        (define sizes
            '(0 1 2 3 10 100 1000))
        (test-start "merge-sort")
        (for-each
            (lambda (index size)
                (let ((xs (generate-random-values size)))
                    (test*
                        (format "#~d (size=~d)" (+ index 1) size)
                        #t
                        (sorted? (merge-sort xs)))))
            (iota (length sizes))
            sizes)
        (test-end)))

(define test.merge-sort-merge
    (lambda ()
        (test-start "merge-sort-merge")
        (test* "#1" '() (merge-sort-merge '() '()))
        (test* "#2" '(1) (merge-sort-merge '(1) '()))
        (test* "#3" '(1) (merge-sort-merge '() '(1)))
        (test* "#4" '(1 1) (merge-sort-merge '(1) '(1)))
        (test* "#5" '(1 2) (merge-sort-merge '(1 2) '()))
        (test* "#6" '(1 2) (merge-sort-merge '(1) '(2)))
        (test* "#7" '(1 2) (merge-sort-merge '() '(1 2)))
        (test* "#8" '(1 2 3 4 5) (merge-sort-merge '(1 3 4) '(2 5)))
        (test-end)))

