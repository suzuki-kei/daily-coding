(use gauche.test)
(load "my-fold")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.my-fold)
        (test.my-fold-right)))

(define test.my-fold
    (lambda ()
        (test-start "my-fold")
        (test* "#1"
            (fold + 0 '())
            (my-fold + 0 '()))
        (test* "#2"
            (fold + 0 '(1 2 3 4 5))
            (my-fold + 0 '(1 2 3 4 5)))
        (test* "#3"
            (fold cons '() '(1 2 3 4 5))
            (my-fold cons '() '(1 2 3 4 5)))
        (test-end)))

(define test.my-fold-right
    (lambda ()
        (test-start "my-fold-right")
        (test* "#1"
            (fold-right + 0 '())
            (my-fold-right + 0 '()))
        (test* "#2"
            (fold-right + 0 '(1 2 3 4 5))
            (my-fold-right + 0 '(1 2 3 4 5)))
        (test* "#3"
            (fold-right cons '() '(1 2 3 4 5))
            (my-fold-right cons '() '(1 2 3 4 5)))
        (test-end)))

