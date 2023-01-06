(use gauche.test)
(load "quick-sort.scm")

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.generate-random-values)
        (test.quick-sort)
        (test.quick-sort-partition)
        (test.cons-if)))

(define test.generate-random-values
    (lambda ()
        (define sizes
            '(0 1 2 3 10 100 1000))
        (test-start "generate-random-values")
        (for-each
            (lambda (index size)
                (test*
                    (format "#~d" (+ index 1))
                    size
                    (length
                        (generate-random-values size))))
            (iota (length sizes))
            sizes)
        (test-end)))

(define test.quick-sort
    (lambda ()
        (define sizes
            '(0 1 2 3 10 100 1000))
        (test-start "quick-sort")
        (for-each
            (lambda (index size)
                (test*
                    (format "#~d" (+ index 1))
                    #t
                    (sorted?
                        (quick-sort
                            (generate-random-values size)))))
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
                    (test*
                        (format "#~d" (+ index 1))
                        #t
                        (receive
                            (less-xs equal-xs greater-xs)
                            (quick-sort-partition pivot xs)
                            (and
                                (every (lambda (x) (< x pivot)) less-xs)
                                (every (lambda (x) (= x pivot)) equal-xs)
                                (every (lambda (x) (> x pivot)) greater-xs))))))
            (iota (length sizes))
            sizes)
        (test-end)))

(define test.cons-if
    (lambda ()
        (test-start "cons-if")
        (test* "#1" '(0 1 2 3) (cons-if < 0 1 '(1 2 3)))
        (test* "#2" '(  1 2 3) (cons-if = 0 1 '(1 2 3)))
        (test* "#3" '(  1 2 3) (cons-if > 0 1 '(1 2 3)))
        (test-end)))

