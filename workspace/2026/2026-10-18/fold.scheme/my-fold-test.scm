(load "my-fold")
(use gauche.test)

(define main
    (lambda (_)
        (test-start "my-fold")
        (test-my-fold)
        (test-end)))

(define test-my-fold
    (lambda ()
        (test-section "my-fold")
        (test*
            "#1"
            (fold + 0 '())
            (my-fold + 0 '()))
        (test*
            "#2"
            (fold + 0 '(1))
            (my-fold + 0 '(1)))
        (test*
            "#3"
            (fold + 0 '(1 2))
            (my-fold + 0 '(1 2)))
        (test*
            "#4"
            (fold + 0 '(1 2 3))
            (my-fold + 0 '(1 2 3)))
        (test*
            "#5"
            (fold * 1 '(1 2 3))
            (my-fold * 1 '(1 2 3)))))

