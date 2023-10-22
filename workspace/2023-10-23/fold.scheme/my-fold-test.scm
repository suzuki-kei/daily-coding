(load "my-fold")
(use gauche.test)

(define main
    (lambda (_)
        (test-all)))

(define test-all
    (lambda ()
        (test-start "my-fold")
        (test.my-fold)
        (test-end)))

(define test.my-fold
    (lambda ()
        (test-section "my-fold")
        (test* "#1"
            (fold + 0 '())
            (my-fold + 0 '()))
        (test* "#2"
            (fold + 0 '(1 2 3))
            (my-fold + 0 '(1 2 3)))
        (test* "#3"
            (fold cons '() '(1 2 3 4 5))
            (my-fold cons '() '(1 2 3 4 5)))))

