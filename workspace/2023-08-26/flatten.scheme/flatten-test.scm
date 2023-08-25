(use gauche.test)
(load "flatten")

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
        (test* "#2" '(a) (flatten '(a)))
        (test* "#3" '(a b) (flatten '(a b)))
        (test* "#4" '(a) (flatten '((a))))
        (test* "#5" '(a b) (flatten '((a) (b))))
        (test* "#6" '(a b c d e) (flatten '(a (b) ((c d) e))))))

