(use srfi-1)
(use gauche.test)

(define alist '(
    (one . 1)
    (two . 2)
    (three . 3)))

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
        (test-start "assoc")
        (test* "#1"
            '(one . 1)
            (assoc 'one alist))
        (test* "#2"
            '(two . 2)
            (assoc 'two alist))
        (test* "#3"
            '(three . 3)
            (assoc 'three alist))
        (test* "#4"
            #f
            (assoc 'four alist))
        (test-end)))

(define test.alist-cons
    (lambda ()
        (test-start "alist-cons")
        (test* "#1"
            '((four . 4) (one . 1) (two . 2) (three . 3))
            (alist-cons 'four 4 alist))
        (test-end)))

(define test.alist-delete
    (lambda ()
        (test-start "alist-delete")
        (test* "#1"
            '((one . 1) (three . 3))
            (alist-delete 'two alist))
        (test-end)))

