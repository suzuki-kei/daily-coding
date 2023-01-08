(use srfi-1)
(use gauche.test)

(define main
    (lambda (arguments)
        (test)))

(define test
    (lambda ()
        (test.assoc)
        (test.alist-cons)
        (test.alist-delete)))

(define test.assoc
    (lambda ()
        (define alist
            '((one . 1) (two . 2) (three . 3)))
        (test-start "assoc")
        (test* "#1" #f (assoc 'zero alist))
        (test* "#2" '(one . 1) (assoc 'one alist))
        (test* "#3" '(two . 2) (assoc 'two alist))
        (test* "#4" '(three . 3) (assoc 'three alist))
        (test-end)))

(define test.alist-cons
    (lambda ()
        (test-start "alist-cons")
        (test* "#1" '((one . 1)) (alist-cons 'one 1 '()))
        (test* "#2" '((one . 1) (two . 2)) (alist-cons 'one 1 '((two . 2))))
        (test* "#3"
            '((one . 1) (two . 2) (three . 3))
            (alist-cons 'one 1 '((two . 2) (three . 3))))
        (test-end)))

(define test.alist-delete
    (lambda ()
        (test-start "alist-delete")
        (test* "#1" '() (alist-delete 'one '()))
        (test* "#2" '() (alist-delete 'one '((one . 1))))
        (test* "#3" '((one . 1)) (alist-delete 'two '((one . 1))))
        (test* "#4" '((two . 2)) (alist-delete 'one '((one . 1) (two . 2))))
        (test* "#5" '((one . 1)) (alist-delete 'two '((one . 1) (two . 2))))
        (test* "#6" '((one . 1) (two . 2)) (alist-delete 'three '((one . 1) (two . 2))))
        (test-end)))

