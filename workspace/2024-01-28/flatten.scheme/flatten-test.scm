(load "flatten")
(use gauche.test)

(define main
    (lambda (_)
        (test-all)))

(define test-all
    (lambda ()
        (test-start "flatten")
        (test.flatten)
        (test-end)))

(define test.flatten
    (lambda ()
        (test-section "flatten")
        (test* "#1" '() (flatten '()))
        (test* "#2" '() (flatten '(())))
        (test* "#3" '() (flatten '((()))))
        (test* "#4" '(a) (flatten '(a)))
        (test* "#5" '(a) (flatten '((a))))
        (test* "#6" '(a) (flatten '(((a)))))
        (test* "#7" '(a b) (flatten '(a b)))
        (test* "#8" '(a b) (flatten '((a) b)))
        (test* "#9" '(a b) (flatten '(a (b))))
        (test* "#10" '(a b) (flatten '((a) (b))))
        (test* "#11" '(a b c d e) (flatten '(a (b) ((c d) e))))
        (test* "#12" '(a b c d e) (flatten '((a (b c)) (d) e)))))

