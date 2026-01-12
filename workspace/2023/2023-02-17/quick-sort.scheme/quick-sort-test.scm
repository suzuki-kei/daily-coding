(use gauche.test)
(load "quick-sort")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.quick-sort)))

(define test.quick-sort
    (lambda ()
        (define sizes
            '(0 1 2 3 10 100 1000))
        (test-start "quick-sort")
        (for-each
            (lambda (index size)
                (let* ((xs (generate-random-values size))
                       (pivot (if (null? xs) 0 (car xs))))
                    (test*
                        (format "#~d (size=~d)" (+ index 1) size)
                        #t
                        (sorted? (quick-sort xs)))))
            (iota (length sizes))
            sizes)
        (test-end)))

