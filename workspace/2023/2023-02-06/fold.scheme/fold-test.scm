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
        (test* "#1"
            (fold + 0 (iota 10))
            (my-fold + 0 (iota 10)))
        (test* "#2"
            (fold cons '() '(a b c))
            (my-fold cons '() '(a b c)))
        (test-end)))

