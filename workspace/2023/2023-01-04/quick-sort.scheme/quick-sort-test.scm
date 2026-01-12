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
        (define tuples
            (map
                list
                '(0 1 2 3 10 100 1000)))
        (test-start "quick-sort")
        (apply-for-each-with-index
            (lambda (index n)
                (let ((xs (generate-random-values n)))
                    (test*
                        (format "#~d" (+ index 1))
                        #t
                        (sorted?
                            (quick-sort xs)))))
            tuples)
        (test-end)))

(define test.quick-sort-partition
    (lambda ()
        (define tuples
            (map
                list
                '(0 1 2 3 10 100 1000)))
        (test-start "quick-sort-partition")
        (apply-for-each-with-index
            (lambda (index n)
                (let* ((xs (generate-random-values n))
                       (pivot (if (null? xs) 0 (car xs))))
                    (receive
                        (less-xs equal-xs greater-xs)
                        (quick-sort-partition pivot xs)
                        (test*
                            (format "#~d" (+ index 1))
                            #t
                            (and
                                (every (lambda (x) (< x pivot)) less-xs)
                                (every (lambda (x) (= x pivot)) equal-xs)
                                (every (lambda (x) (> x pivot)) greater-xs))))))
            tuples)
        (test-end)))

(define apply-for-each-with-index
    (lambda (callback tuples)
        (for-each
            (lambda (index tuple)
                (apply
                    callback
                    (cons index tuple)))
            (iota
                (length tuples))
            tuples)))

