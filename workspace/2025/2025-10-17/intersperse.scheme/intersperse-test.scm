(use gauche.test)
(load "intersperse")

(define main
    (lambda (_)
        (test-start "intersperse")
        (test-intersperse)
        (test-end)))

(define test-intersperse
    (lambda ()
        (test-section "intersperse")
        (test* "#1" '() (intersperse '_ '()))
        (test* "#2" '(a) (intersperse '_ '(a)))
        (test* "#3" '(a _ b) (intersperse '_ '(a b)))
        (test* "#4" '(a _ b _ c) (intersperse '_ '(a b c)))
        (test* "#5" '(a x b x c) (intersperse 'x '(a b c)))))

