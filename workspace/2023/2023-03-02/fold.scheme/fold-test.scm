(use gauche.test)
(load "fold")

(define main
    (lambda (arguments)
        (test-all)))

(define test-all
    (lambda ()
        (test.fold)))

(define test.fold
    (lambda ()
        (test-start "fold")
        (test* "#1" 0 (my-fold + 0 '()))
        (test* "#2" 1 (my-fold + 0 '(1)))
        (test* "#3" 3 (my-fold + 0 '(1 2)))
        (test* "#4" 6 (my-fold + 0 '(1 2 3)))
        (test* "#5" '() (my-fold cons '() '()))
        (test* "#5" '(1) (my-fold cons '() '(1)))
        (test* "#6" '(2 1) (my-fold cons '() '(1 2)))
        (test* "#7" '(3 2 1) (my-fold cons '() '(1 2 3)))
        (test-end)))

