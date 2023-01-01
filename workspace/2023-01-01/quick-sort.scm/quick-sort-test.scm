
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
        (test-start "quick-sort")
        (for-each
            (lambda (i)
                (test*
                    (format "#~d" (+ i 1))
                    #t
                    (sorted?
                        (quick-sort
                            (generate-random-values 20)))))
            (iota 100))
        (test-end)))

(define test.partition
    (lambda ()
        (test-start "partition")
        (for-each
            (lambda (i)
                (let* ((xs (generate-random-values 20))
                       (pivot (car xs)))
                    (receive
                        (less-xs equal-xs greater-xs)
                        (partition pivot xs)
                        (test*
                            (format "#~d" (+ i 1))
                            #t
                            (and
                                (every (lambda (x) (< x pivot)) less-xs)
                                (every (lambda (x) (= x pivot)) equal-xs)
                                (every (lambda (x) (> x pivot)) greater-xs))))))
            (iota 100))
        (test-end)))

