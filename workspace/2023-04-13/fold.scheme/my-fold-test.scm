(use gauche.test)
(load "my-fold")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.my-fold)))

(define test.my-fold
    (lambda ()
        (test-start "my-fold")
        (test* "#1"
            (fold + 0 '())
            (my-fold + 0 '()))
        (test* "#2"
            (fold + 0 (iota 10 1))
            (my-fold + 0 (iota 10 1)))
        (test* "#3"
            (fold cons '() (iota 10 1))
            (my-fold cons '() (iota 10 1)))
        (test-end)))

