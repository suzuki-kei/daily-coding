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
        (test* "#5" '() (flatten '(() (()))))
        (test* "#6" '() (flatten '((()) ())))
        (test* "#7" '() (flatten '((()) (()))))
        (test* "#8" '(a) (flatten '(a)))
        (test* "#9" '(a) (flatten '((a))))
        (test* "#10" '(a) (flatten '(((a)))))
        (test* "#11" '(a b) (flatten '(a b)))
        (test* "#12" '(a b) (flatten '(a (b))))
        (test* "#13" '(a b) (flatten '((a) b)))
        (test* "#14" '(a b) (flatten '((a) (b))))
        (test* "#15" '(a b c d e) (flatten '(a (b) ((c d) e))))
        (test* "#16" '(a b c d e) (flatten '((a (b c)) (d) e)))))

