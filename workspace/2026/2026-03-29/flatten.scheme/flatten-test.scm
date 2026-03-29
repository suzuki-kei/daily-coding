(use gauche.test)
(load "flatten")

(define main
    (lambda (_)
        (test-start "flatten")
        (test-flatten)
        (test-end)))

(define test-flatten
    (lambda ()
        (test-section "flatten")
        (test* "#1" '() (flatten '()))
        (test* "#2" '() (flatten '(())))
        (test* "#3" '() (flatten '((()))))
        (test* "#4" '() (flatten '(() ())))
        (test* "#5" '() (flatten '(() () ())))
        (test* "#6" '(a) (flatten '(a)))
        (test* "#7" '(a b) (flatten '(a (b))))
        (test* "#8" '(a b c) (flatten '(a (b) ((c)))))
        (test* "#9" '(a b c d) (flatten '(a (b) ((c d)))))
        (test* "#10" '(a b c d e) (flatten '(a (b) ((c d) e))))
        (test* "#11" '(a) (flatten '((a))))
        (test* "#12" '(a b) (flatten '((a (b)))))
        (test* "#13" '(a b c) (flatten '((a (b c)))))
        (test* "#14" '(a b c d) (flatten '((a (b c)) (d))))
        (test* "#15" '(a b c d e) (flatten '((a (b c)) (d) e)))))

