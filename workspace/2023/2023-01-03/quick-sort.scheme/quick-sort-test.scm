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
        (define xss1 '(
            ()
            (1)
            (1 2)
            (2 1)
            (1 2 3)
            (1 3 2)
            (2 1 3)
            (2 3 1)
            (3 1 2)
            (3 2 1)))
        (define xss2
            (map
                generate-random-values
                '(0 1 2 3 10 100 1000)))
        (define tuples
            (map list
                (append xss1 xss2)))

        (test-start "quick-sort")
        (apply-for-each-with-index
            (lambda (index xs)
                (test*
                    (format "#~d" (+ index 1))
                    #t
                    (sorted? (quick-sort xs))))
            tuples)
        (test-end)))

(define test.quick-sort-partition
    (lambda ()
        ; (pivot xs) のリスト.
        (define tuples
            (append
                '(
                    (0 ())
                    (0 (1))
                    (1 (1))
                    (2 (1)))
                (map
                    (lambda (xs) (list (car xs) xs))
                    (map
                        generate-random-values
                        '(1 2 3 10 100 1000)))))
        (test-start "test.quick-sort-partition")
        (apply-for-each-with-index
            (lambda (index pivot xs)
                (receive
                    (less-xs equal-xs greater-xs)
                    (quick-sort-partition pivot xs)
                    (test*
                        (format "#~d" (+ index 1))
                        #t
                        (and
                            (every (lambda (x) (< x pivot)) less-xs)
                            (every (lambda (x) (= x pivot)) equal-xs)
                            (every (lambda (x) (> x pivot)) greater-xs)))))
            tuples)
        (test-end)))

(define apply-for-each-with-index
    (lambda (callback tuples)
        (for-each
            (lambda (index tuple)
                (apply callback (cons index tuple)))
            (iota
                (length tuples))
            tuples)))

