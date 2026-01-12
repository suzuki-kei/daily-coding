(use gauche.test)
(load "quick-sort.scm")

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.quick-sort)
        (test.quick-sort-partition)))

(define test.quick-sort
    (lambda ()
        (define sizes
            '(0 1 2 3 10 100 1000))
        (test-start "quick-sort")
        (for-each
            (lambda (index size)
                (let ((xs (generate-random-values size)))
                    (test*
                        (format "#~d (size=~d)" (+ index 1) size)
                        #t
                        (sorted?  (quick-sort xs)))))
            (iota (length sizes))
            sizes)
        (test-end)))

(define test.quick-sort-partition
    (lambda ()
        (define sizes
            '(0 1 2 3 10 100 1000))
        (test-start "quick-sort-partition")
        (for-each
            (lambda (index size)
                (let* ((xs (generate-random-values size))
                       (pivot (if (null? xs) 0 (car xs))))
                    (receive
                        (less-xs equal-xs greater-xs)
                        (quick-sort-partition pivot xs)
                        (test*
                            (format "#~d (size=~d)" (+ index 1) size)
                            #t
                            (and
                                (every (lambda (x) (< x pivot)) less-xs)
                                (every (lambda (x) (= x pivot)) equal-xs)
                                (every (lambda (x) (> x pivot)) greater-xs))))))
            (iota (length sizes))
            sizes)
        (test-end)))

