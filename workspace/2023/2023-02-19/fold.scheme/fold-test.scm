(use gauche.test)
(load "fold")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.my-fold)))

(define test.my-fold
    (lambda ()
        (test-start "my-fold")
        (test* "#1" 0 (my-fold + 0 '()))
        (test* "#2" 1 (my-fold + 0 '(1)))
        (test* "#3" 3 (my-fold + 0 '(1 2)))
        (test* "#4" 6 (my-fold + 0 '(1 2 3)))
        (test-end)))

